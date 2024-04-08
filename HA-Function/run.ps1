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



#--------------------------------------------------------------------------
# Main code block for Azure function app                       
#--------------------------------------------------------------------------


$Password = ConvertTo-SecureString $env:SP_PASSWORD -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($env:SP_USERNAME, $Password)
$AzureEnv = Get-AzEnvironment -Name $env:AZURECLOUD
Connect-AzAccount -ServicePrincipal -Tenant $env:TENANTID -Credential $Credential -Subscription $env:SUBSCRIPTIONID -Environment $AzureEnv

$Context = Get-AzContext
Set-AzContext -Context $Context

$FW1Down = Test-VMStatus -VM $VMFW1Name -FwResourceGroup $FW1RGName

Write-Host " FWDown is: $FW1Down "

$Res = Find-AzureRmResource -TagName nva_ha_udr -TagValue $TagValue

Write-Host $Res
