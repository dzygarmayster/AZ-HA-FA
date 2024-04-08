# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format.
$currentUTCtime = (Get-Date).ToUniversalTime()

# The 'IsPastDue' property is 'true' when the current function invocation is later than scheduled.
#if ($Timer.IsPastDue) {
#    Write-Host "PowerShell timer is running late!"
#}
#
# Write an information log with the current time.
#Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"

Write-Output -InputObject "HA NVA timer trigger function executed at:$(Get-Date)"

#--------------------------------------------------------------------------
# Set firewall monitoring variables here
#--------------------------------------------------------------------------

$VMFW1Name = $env:FW1NAME      # Set the Name of the primary NVA firewall
$VMFW2Name = $env:FW2NAME      # Set the Name of the secondary NVA firewall
$FW1RGName = $env:FWRGNAME     # Set the ResourceGroup that contains FW1
$FW2RGName = $env:FWRGNAME     # Set the ResourceGroup that contains FW2
$Monitor = $env:FWMONITOR      # "VMStatus" or "TCPPort" are valid values
$TagValue = $env:FWUDRTAG

#--------------------------------------------------------------------------
# Set the failover and failback behavior for the firewalls
#--------------------------------------------------------------------------

$FailOver = $True              # Trigger to enable fail-over to secondary NVA firewall if primary NVA firewall drops when active
$FailBack = $True              # Trigger to enable fail-back to primary NVA firewall is secondary NVA firewall drops when active
$IntTries = $env:FWTRIES       # Number of Firewall tests to try 
$IntSleep = $env:FWDELAY       # Delay in seconds between tries


#--------------------------------------------------------------------------
# Code blocks for supporting functions
#--------------------------------------------------------------------------


Function Test-VMStatus ($VM, $FWResourceGroup) 
{
  $VMDetail = Get-AzVM -ResourceGroupName $FWResourceGroup -Name $VM -Status
  foreach ($VMStatus in $VMDetail.Statuses)
  { 
    $Status = $VMStatus.code
      
    if($Status.CompareTo('PowerState/running') -eq 0)
    {
      Return $False
    }
  }
  Return $True  
}

Function Start-Failover 
{
  foreach ($SubscriptionID in $Script:ListOfSubscriptionIDs){
    Set-AzContext -Subscription $SubscriptionID
    $RTable = @()
    $TagValue = $env:FWUDRTAG
    $Res = Get-AzResource -TagName nva_ha_udr -TagValue $TagValue

    foreach ($RTable in $Res)
    {
      $Table = Get-AzRouteTable -ResourceGroupName $RTable.ResourceGroupName -Name $RTable.Name
      
      foreach ($RouteName in $Table.Routes)
      {
        Write-Output -InputObject "Updating route table..."
        Write-Output -InputObject $RTable.Name

        for ($i = 0; $i -lt $PrimaryInts.count; $i++)
        {
          if($RouteName.NextHopIpAddress -eq $SecondaryInts[$i])
          {
            Write-Output -InputObject 'Secondary NVA is already ACTIVE' 
            
          }
          elseif($RouteName.NextHopIpAddress -eq $PrimaryInts[$i])
          {
            Set-AzRouteConfig -Name $RouteName.Name  -NextHopType VirtualAppliance -RouteTable $Table -AddressPrefix $RouteName.AddressPrefix -NextHopIpAddress $SecondaryInts[$i] 
          }
        }

      }
  
      $UpdateTable = [scriptblock]{param($Table) Set-AzRouteTable -RouteTable $Table}
      &$UpdateTable $Table

    }
  }

#  Send-AlertMessage -message "NVA Alert: Failover to Secondary FW2"

}

Function Get-FWInterfaces
{
  $Nics = Get-AzNetworkInterface | Where-Object -Property VirtualMachine -NE -Value $Null
  $VMS1 = Get-AzVM -Name $VMFW1Name -ResourceGroupName $FW1RGName
  $VMS2 = Get-AzVM -Name $VMFW2Name -ResourceGroupName $FW2RGName

  foreach($Nic in $Nics)
  {

    if (($Nic.VirtualMachine.Id -EQ $VMS1.Id) -Or ($Nic.VirtualMachine.Id -EQ $VMS2.Id)) 
    {
      $VM = $VMS | Where-Object -Property Id -EQ -Value $Nic.VirtualMachine.Id
      $Prv = $Nic.IpConfigurations | Select-Object -ExpandProperty PrivateIpAddress  

      if ($VM.Name -eq $VMFW1Name)
      {
        $Script:PrimaryInts += $Prv
      }
      elseif($VM.Name -eq $vmFW2Name)
      {
        $Script:SecondaryInts += $Prv
      }

    }

  }
}


Function Get-Subscriptions
{
  Write-Output -InputObject "Enumerating all subscriptins ..."
  $Script:ListOfSubscriptionIDs = (Get-AzSubscription).SubscriptionId
  Write-Output -InputObject $Script:ListOfSubscriptionIDs
}

#--------------------------------------------------------------------------
# Main code block for Azure function app                       
#--------------------------------------------------------------------------


$Password = ConvertTo-SecureString $env:SP_PASSWORD -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($env:SP_USERNAME, $Password)
$AzureEnv = Get-AzEnvironment -Name $env:AZURECLOUD
Connect-AzAccount -ServicePrincipal -Tenant $env:TENANTID -Credential $Credential -Subscription $env:SUBSCRIPTIONID -Environment $AzureEnv

$Context = Get-AzContext
Set-AzContext -Context $Context

$Script:PrimaryInts = @()
$Script:SecondaryInts = @()
$Script:ListOfSubscriptionIDs = @()

# Check NVA firewall status $intTries with $intSleep between tries

$CtrFW1 = 0
$CtrFW2 = 0
$FW1Down = $True
$FW2Down = $True

$VMS = Get-AzVM

Get-Subscriptions
Get-FWInterfaces

$FW1Down = Test-VMStatus -VM $VMFW1Name -FwResourceGroup $FW1RGName

Write-Host " FW1Down is: $FW1Down "
Get-AzResource -TagName nva_ha_udr -TagValue $TagValue | Format-Table
$Res = Get-AzResource -TagName nva_ha_udr -TagValue $TagValue 
Write-Host " Interfaces: $PrimaryInts $SecondaryInts "
Write-Host " Route Table with tag: $Res "

Write-Host " ListofSubs: $ListOfSubscriptionIDs "
