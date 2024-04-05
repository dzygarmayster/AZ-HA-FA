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
$FW1RGName = $env:FWRGNAME     # Set the ResourceGroup that contains FW1



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



$Password = ConvertTo-SecureString $env:SP_PASSWORD -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($env:SP_USERNAME, $Password)
$AzureEnv = Get-AzEnvironment -Name $env:AZURECLOUD
Connect-AzAccount -ServicePrincipal -Tenant $env:TENANTID -Credential $Credential -Subscription $env:SUBSCRIPTIONID -Environment $AzureEnv

$Context = Get-AzContext
Set-AzContext -Context $Context

Write-Host $FW1RGName $VMFW1Name

$FW1Down = Test-VMStatus -VM $VMFW1Name -FwResourceGroup $FW1RGName

Write-Host $FW1Down
