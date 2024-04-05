# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format.
$currentUTCtime = (Get-Date).ToUniversalTime()

# The 'IsPastDue' property is 'true' when the current function invocation is later than scheduled.
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}

# Write an information log with the current time.
Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"



$VMFW1Name = $env:FW1NAME      # Set the Name of the primary NVA firewall
$FW1RGName = $env:FWRGNAME     # Set the ResourceGroup that contains FW1


$Password = ConvertTo-SecureString $env:SP_PASSWORD -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($env:SP_USERNAME, $Password)
$AzureEnv = Get-AzEnvironment -Name $env:AZURECLOUD
Connect-AzAccount -ServicePrincipal -Tenant $env:TENANTID -Credential $Credential -Subscription $env:SUBSCRIPTIONID -Environment $AzureEnv

$Context = Get-AzContext
Set-AzContext -Context $Context

Write-Host $FW1RGName $VMFW1Name

# Get-AzVM -ResourceGroupName $FW1RGName -Name $VMFW1Name


$VMDetail = Get-AzVM -ResourceGroupName $FW1RGName -Name $VMFW1Name -StatusCode

Write-Host $VMDetail