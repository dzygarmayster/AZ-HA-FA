# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format.
$currentUTCtime = (Get-Date).ToUniversalTime()

#--------------------------------------------------------------------------
#
# High Availability (HA) Network Virtual Appliance (NVA) Failover Function
#
# This script provides a sample for monitoring HA NVA firewall status and performing
# failover and/or failback if needed.
#
# This script is used as part of an Azure function app called by a Timer Trigger event.  
#
# To configure this function app, the following items must be setup:
#
#   - Provision the pre-requisite Azure Resource Groups, Virtual Networks and Subnets, Network Virtual Appliances
#
#   - Set Firewall VM names and Resource Group in the Azure function app settings
#     FW1NAME, FW2NAME, FWMONITOR, FW1FQDN, FW1PORT, FW2FQDN, FW2PORT, FWRGNAME, FWTRIES, FWDELAY, FWUDRTAG must be added
#     FWMONITOR = "VMStatus" or "TCPPort" - If using "TCPPort", then also set FW1FQDN, FW2FQDN, FW1PORT and FW2PORT values
#
#   - Set Timer Schedule where positions represent: Seconds - Minutes - Hours - Day - Month - DayofWeek
#     Example:  "0 */5 * * * *" to run on multiples of 5 minutes on the 0-second mark
#
#--------------------------------------------------------------------------

Write-Output -InputObject "HA NVA timer trigger function executed at:$(Get-Date)"

#--------------------------------------------------------------------------
# Set firewall monitoring variables here
#--------------------------------------------------------------------------

$VMFW1Name = $env:FW1NAME      # Set the Name of the primary NVA firewall
$VMFW2Name = $env:FW2NAME      # Set the Name of the secondary NVA firewall
$FW1RGName = $env:FW1RGNAME     # Set the ResourceGroup that contains FW1
$FW2RGName = $env:FW2RGNAME     # Set the ResourceGroup that contains FW2
$Monitor = $env:FWMONITOR      # "VMStatus" or "TCPPort" are valid values
$TagValue = $env:FWUDRTAG	   # Set the Route table tag. TagName: nva_ha_udr, TagValue: use your own

#--------------------------------------------------------------------------
# The parameters below are required if using "TCPPort" mode for monitoring
#--------------------------------------------------------------------------

$TCPFW1Server = $env:FW1IP   # Hostname of the site to be monitored via the primary NVA firewall if using "TCPPort"
$TCPFW1Port = $env:FWPORT     # TCP Port of the site to be monitored via the primary NVA firewall if using "TCPPort"
$TCPFW2Server = $env:FW2IP # Hostname of the site to be monitored via the secondary NVA firewall if using "TCPPort"
$TCPFW2Port = $env:FWPORT     # TCP Port of the site to be monitored via the secondary NVA firewall if using "TCPPort"

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



Function Test-TCPPort ($Server, $Port)
{
  $TCPClient = New-Object -TypeName system.Net.Sockets.TcpClient
  $Iar = $TCPClient.BeginConnect($Server, $Port, $Null, $Null)
  $Wait = $Iar.AsyncWaitHandle.WaitOne(1000, $False)
  return $Wait
}

Function CheckSecondaryFWhop
{
    $RTable = @()
    $TagValue = $env:FWUDRTAG
    $Res = Get-AzResource -TagName nva_ha_udr -TagValue $TagValue

    foreach ($RTable in $Res)
    {
        $SecondaryFWhops = Get-AzRouteTable -ResourceGroupName $RTable.ResourceGroupName -Name $RTable.Name | Get-AzRouteConfig | Where-Object -Property NextHopIpAddress -Like $SecondaryInts[0]
    }
    
    if($SecondaryFWhops.Count -eq 0) 
    {
        return $False
    }
    else
    {
        return $True
    }
    
}

Function Start-Failover 
{
    $RTable = @()
    $TagValue = $env:FWUDRTAG
    $Res = Get-AzResource -TagName nva_ha_udr -TagValue $TagValue

    foreach ($RTable in $Res)
    {
      $Table = Get-AzRouteTable -ResourceGroupName $RTable.ResourceGroupName -Name $RTable.Name
      
      foreach ($RouteName in $Table.Routes)
      {
        if($RouteName.NextHopIpAddress -eq $SecondaryInts[0])
        {
          Write-Output -InputObject 'Secondary NVA is already ACTIVE' 
        }
        elseif($RouteName.NextHopIpAddress -eq $PrimaryInts[0])
        {
         $Script:RoutesToChange += $RouteName.Name
		 $Script:PrefixesToChange += $RouteName.AddressPrefix
        }
      }
      
	  for ($i = 0; $i -lt $RoutesToChange.count; $i++)
	  {
		Write-Output -InputObject "Updating route table..."
		Write-Host $RoutesToChange[$i] $PrefixesToChange[$i]
		Set-AzRouteConfig -Name $RoutesToChange[$i] -NextHopType VirtualAppliance -RouteTable $Table -AddressPrefix $PrefixesToChange[$i] -NextHopIpAddress $SecondaryInts[0]
	  }
      
      $UpdateTable = [scriptblock]{param($Table) Set-AzRouteTable -RouteTable $Table}
      &$UpdateTable $Table

    }

#  Send-AlertMessage -message "NVA Alert: Failover to Secondary FW2"

}

Function Start-Failback 
{
    $RTable = @()
    $TagValue = $env:FWUDRTAG
    $Res = Get-AzResource -TagName nva_ha_udr -TagValue $TagValue

    foreach ($RTable in $Res)
    {
      $Table = Get-AzRouteTable -ResourceGroupName $RTable.ResourceGroupName -Name $RTable.Name
	 
      foreach ($RouteName in $Table.Routes)
      {
        if($RouteName.NextHopIpAddress -eq $PrimaryInts[0])
        {
            Write-Output -InputObject 'Primary NVA is already ACTIVE' 
        }
        elseif($RouteName.NextHopIpAddress -eq $SecondaryInts[0])
        {
			$Script:RoutesToChange += $RouteName.Name
			$Script:PrefixesToChange += $RouteName.AddressPrefix
        }  
      }  
	
	  for ($i = 0; $i -lt $RoutesToChange.count; $i++)
	  {
		Write-Output -InputObject "Updating route table..."
		Write-Host $RoutesToChange[$i] $PrefixesToChange[$i]
		Set-AzRouteConfig -Name $RoutesToChange[$i] -NextHopType VirtualAppliance -RouteTable $Table -AddressPrefix $PrefixesToChange[$i] -NextHopIpAddress $PrimaryInts[0]
	  }
	  
      $UpdateTable = [scriptblock]{param($Table) Set-AzRouteTable -RouteTable $Table}
      &$UpdateTable $Table 

    }
  
# Send-AlertMessage -message "NVA Alert: Failback to Primary FW1"

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

#--------------------------------------------------------------------------
# Main code block for Azure function app                       
#--------------------------------------------------------------------------

$Script:PrimaryInts = @()
$Script:SecondaryInts = @()
$Script:RoutesToChange = @()
$Script:PrefixesToChange = @()

# Check NVA firewall status $intTries with $intSleep between tries

$CtrFW1 = 0
$CtrFW2 = 0
$FW1Down = $True
$FW2Down = $True

$VMS = Get-AzVM

Get-FWInterfaces

$Res = Get-AzResource -TagName nva_ha_udr -TagValue $TagValue 
Write-Host " Interfaces: $PrimaryInts $SecondaryInts "
Write-Host " Route Table with tag: " $Res.Name

$IsSecondaryFWhop = CheckSecondaryFWhop
Write-Host "Is Secondary FW Active in routes: " $IsSecondaryFWhop

##################################################
# Test primary and secondary NVA firewall status
##################################################

For ($Ctr = 1; $Ctr -le $IntTries; $Ctr++)
{
  
  if ($Monitor -eq 'VMStatus')
  {
    $FW1Down = Test-VMStatus -VM $VMFW1Name -FwResourceGroup $FW1RGName
    $FW2Down = Test-VMStatus -VM $VMFW2Name -FwResourceGroup $FW2RGName
  }

  if ($Monitor -eq 'TCPPort')
  {
    $FW1Down = -not (Test-TCPPort -Server $TCPFW1Server -Port $TCPFW1Port)
    $FW2Down = -not (Test-TCPPort -Server $TCPFW2Server -Port $TCPFW2Port)
  }

  Write-Output -InputObject "Pass $Ctr of $IntTries - FW1Down is $FW1Down, FW2Down is $FW2Down"

  if ($FW1Down) 
  {
    $CtrFW1++
  }

  if ($FW2Down) 
  {
    $CtrFW2++
  }

  Write-Output -InputObject "Sleeping $IntSleep seconds"
  Start-Sleep $IntSleep
}

########################################################################
# Reset individual test status and determine overall NVA firewall status
########################################################################

$FW1Down = $False
$FW2Down = $False

if ($CtrFW1 -eq $intTries) 
{
  $FW1Down = $True
}

if ($CtrFW2 -eq $intTries) 
{
  $FW2Down = $True
}

##################################
# Failover or failback if needed
##################################

if (($FW1Down) -and -not ($FW2Down))
{
  if ($FailOver)
  {
    Write-Output -InputObject 'FW1 Down - Failing over to FW2'
    Start-Failover 
  }
}
elseif (-not ($FW1Down) -and ($FW2Down))
{
  if ($FailBack)
  {
    Write-Output -InputObject 'FW2 Down - Failing back to FW1'
    Start-Failback
  }
  else 
  {
    Write-Output -InputObject 'FW2 Down - Failing back disabled'
  }
}
elseif (-not ($FW1Down) -and -not ($FW2Down) -and ($IsSecondaryFWhop))
{
  if ($FailBack)
  {
    Write-Output -InputObject 'Both FW1 and FW2 Up - Failing back to FW1'
    Start-Failback
  }
  else 
  {
    Write-Output -InputObject 'FW2 Down - Failing back disabled'
  }
}
elseif (($FW1Down) -and ($FW2Down))
{
  Write-Output -InputObject 'Both FW1 and FW2 Down - Manual recovery action required'
  #Send-AlertMessage -message "NVA Alert: Both FW1 and FW2 Down - Manual recovery action is required"
}
else
{
  Write-Output -InputObject 'Both FW1 and FW2 Up - No action is required'
}

