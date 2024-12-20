#
# Module manifest for module 'Az.Resources'
#
# Generated by: Microsoft Corporation
#
# Generated on: 11/23/2023
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'Az.Resources.psm1'

# Version number of this module.
ModuleVersion = '7.0.0'

# Supported PSEditions
CompatiblePSEditions = 'Core', 'Desktop'

# ID used to uniquely identify this module
GUID = '48bb344d-4c24-441e-8ea0-589947784700'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = 'Microsoft Corporation. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Microsoft Azure PowerShell - Azure Resource Manager and Active Directory cmdlets in Windows PowerShell and PowerShell Core.  Manages subscriptions, tenants, resource groups, deployment templates, providers, and resource permissions in Azure Resource Manager.  Provides cmdlets for managing resources generically across resource providers.
For more information on Resource Manager, please visit the following: https://learn.microsoft.com/azure/azure-resource-manager/
For more information on Active Directory, please visit the following: https://learn.microsoft.com/azure/active-directory/fundamentals/active-directory-whatis'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
DotNetFrameworkVersion = '4.7.2'

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = 'Microsoft.Azure.Management.Authorization.dll', 
               'Microsoft.Azure.Management.ResourceManager.dll', 
               'Microsoft.Azure.Management.ManagementGroups.dll', 
               'Microsoft.Extensions.Caching.Abstractions.dll', 
               'Microsoft.Extensions.Caching.Memory.dll', 
               'Microsoft.Extensions.DependencyInjection.Abstractions.dll', 
               'Microsoft.Extensions.Options.dll', 
               'Microsoft.Extensions.Primitives.dll', 
               'System.Runtime.CompilerServices.Unsafe.dll', 
               'MSGraph.Autorest\bin\Az.MSGraph.private.dll', 
               'Authorization.Autorest\bin\Az.Authorization.private.dll', 
               'Microsoft.Azure.PowerShell.Resources.Management.Sdk.dll', 
               'Policy.Autorest\bin\Az.Policy.private.dll'

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = 'Resources.format.ps1xml', 'ResourceManager.format.ps1xml', 
               'ResourceManager.generated.format.ps1xml', 'Tags.format.ps1xml', 
               'MSGraph.Autorest\Az.MSGraph.format.ps1xml', 
               'Authorization.Autorest\Az.Authorization.format.ps1xml', 
               'Policy.Autorest\Az.Policy.format.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('MSGraph.Autorest\Az.MSGraph.psm1', 'Authorization.Autorest\Az.Authorization.psm1', 'Policy.Autorest\Az.Policy.psm1')

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Add-AzADAppPermission', 'Add-AzADGroupMember', 
               'Get-AzADAppCredential', 'Get-AzADApplication', 
               'Get-AzADAppPermission', 'Get-AzADGroup', 'Get-AzADGroupMember', 
               'Get-AzADServicePrincipal', 'Get-AzADSpCredential', 'Get-AzADUser', 
               'New-AzADAppCredential', 'New-AzADApplication', 'New-AzADGroup', 
               'New-AzADServicePrincipal', 'New-AzADSpCredential', 'New-AzADUser', 
               'Remove-AzADAppCredential', 'Remove-AzADApplication', 
               'Remove-AzADAppPermission', 'Remove-AzADGroup', 
               'Remove-AzADGroupMember', 'Remove-AzADServicePrincipal', 
               'Remove-AzADSpCredential', 'Remove-AzADUser', 
               'Update-AzADApplication', 'Update-AzADServicePrincipal', 
               'Update-AzADUser', 'Get-AzRoleAssignmentSchedule', 
               'Get-AzRoleAssignmentScheduleInstance', 
               'Get-AzRoleAssignmentScheduleRequest', 
               'Get-AzRoleEligibilitySchedule', 
               'Get-AzRoleEligibilityScheduleInstance', 
               'Get-AzRoleEligibilityScheduleRequest', 
               'Get-AzRoleEligibleChildResource', 'Get-AzRoleManagementPolicy', 
               'Get-AzRoleManagementPolicyAssignment', 
               'New-AzRoleAssignmentScheduleRequest', 
               'New-AzRoleEligibilityScheduleRequest', 
               'New-AzRoleManagementPolicyAssignment', 
               'Remove-AzRoleManagementPolicy', 
               'Remove-AzRoleManagementPolicyAssignment', 
               'Stop-AzRoleAssignmentScheduleRequest', 
               'Stop-AzRoleEligibilityScheduleRequest', 
               'Update-AzRoleManagementPolicy', 'Update-AzADGroup', 
               'Get-AzADAppFederatedCredential', 'New-AzADAppFederatedCredential', 
               'Remove-AzADAppFederatedCredential', 
               'Update-AzADAppFederatedCredential', 'Get-AzADOrganization', 
               'Get-AzADGroupOwner', 'New-AzADGroupOwner', 'Remove-AzADGroupOwner', 
               'Get-AzPolicyAssignment', 'Get-AzPolicyDefinition', 
               'Get-AzPolicyExemption', 'Get-AzPolicySetDefinition', 
               'New-AzPolicyAssignment', 'New-AzPolicyDefinition', 
               'New-AzPolicyExemption', 'New-AzPolicySetDefinition', 
               'Remove-AzPolicyAssignment', 'Remove-AzPolicyDefinition', 
               'Remove-AzPolicyExemption', 'Remove-AzPolicySetDefinition', 
               'Update-AzPolicyAssignment', 'Update-AzPolicyDefinition', 
               'Update-AzPolicyExemption', 'Update-AzPolicySetDefinition'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = 'Get-AzProviderOperation', 'Remove-AzRoleAssignment', 
               'Get-AzRoleAssignment', 'New-AzRoleAssignment', 
               'Set-AzRoleAssignment', 'Get-AzRoleDefinition', 
               'New-AzRoleDefinition', 'Set-AzRoleDefinition', 
               'Remove-AzRoleDefinition', 'Remove-AzResourceGroup', 
               'Get-AzProviderFeature', 'Register-AzProviderFeature', 
               'Unregister-AzProviderFeature', 'Get-AzProviderPreviewFeature', 
               'Register-AzProviderPreviewFeature', 
               'Unregister-AzProviderPreviewFeature', 'Get-AzLocation', 
               'Export-AzResourceGroup', 'Get-AzResourceProvider', 
               'Register-AzResourceProvider', 'Unregister-AzResourceProvider', 
               'Get-AzResourceGroupDeployment', 'New-AzResourceGroupDeployment', 
               'Remove-AzResourceGroupDeployment', 
               'Stop-AzResourceGroupDeployment', 'Test-AzResourceGroupDeployment', 
               'Set-AzResourceGroup', 'New-AzResourceGroup', 'Get-AzResourceGroup', 
               'Save-AzResourceGroupDeploymentTemplate', 
               'Get-AzResourceGroupDeploymentOperation', 'Get-AzResourceLock', 
               'Invoke-AzResourceAction', 'Move-AzResource', 'New-AzResourceLock', 
               'Get-AzPolicyAssignment', 'Get-AzPolicyDefinition', 
               'Get-AzPolicySetDefinition', 'Get-AzPolicyExemption', 
               'New-AzPolicyAssignment', 'New-AzPolicyDefinition', 
               'New-AzPolicySetDefinition', 'New-AzPolicyExemption', 
               'Remove-AzPolicyAssignment', 'Remove-AzPolicyDefinition', 
               'Remove-AzPolicySetDefinition', 'Remove-AzPolicyExemption', 
               'Set-AzPolicyAssignment', 'Set-AzPolicyDefinition', 
               'Set-AzPolicySetDefinition', 'Set-AzPolicyExemption', 
               'Remove-AzResource', 'Remove-AzResourceLock', 'Set-AzResource', 
               'New-AzResource', 'Set-AzResourceLock', 'Get-AzResource', 
               'Get-AzManagedApplicationDefinition', 
               'New-AzManagedApplicationDefinition', 
               'Set-AzManagedApplicationDefinition', 
               'Remove-AzManagedApplicationDefinition', 'Get-AzManagedApplication', 
               'New-AzManagedApplication', 'Set-AzManagedApplication', 
               'Remove-AzManagedApplication', 'Get-AzManagementGroup', 
               'New-AzManagementGroup', 'Update-AzManagementGroup', 
               'Remove-AzManagementGroup', 'New-AzManagementGroupSubscription', 
               'Remove-AzManagementGroupSubscription', 'New-AzDeployment', 
               'Get-AzDeployment', 'Test-AzDeployment', 'Remove-AzDeployment', 
               'Stop-AzDeployment', 'Save-AzDeploymentTemplate', 
               'Get-AzDeploymentOperation', 'Get-AzManagementGroupDeployment', 
               'Test-AzManagementGroupDeployment', 
               'New-AzManagementGroupDeployment', 
               'Get-AzManagementGroupDeploymentOperation', 
               'Save-AzManagementGroupDeploymentTemplate', 
               'Stop-AzManagementGroupDeployment', 
               'Remove-AzManagementGroupDeployment', 'Get-AzTenantDeployment', 
               'Test-AzTenantDeployment', 'New-AzTenantDeployment', 
               'Get-AzTenantDeploymentOperation', 
               'Save-AzTenantDeploymentTemplate', 'Stop-AzTenantDeployment', 
               'Remove-AzTenantDeployment', 'Get-AzPolicyAlias', 'Remove-AzTag', 
               'Get-AzTag', 'New-AzTag', 'Get-AzDenyAssignment', 'Update-AzTag', 
               'Get-AzDeploymentScript', 'Get-AzDeploymentScriptLog', 
               'Save-AzDeploymentScriptLog', 'Remove-AzDeploymentScript', 
               'Get-AzDeploymentWhatIfResult', 
               'Get-AzResourceGroupDeploymentWhatIfResult', 
               'Get-AzManagementGroupDeploymentWhatIfResult', 
               'Get-AzTenantDeploymentWhatIfResult', 'Get-AzTemplateSpec', 
               'New-AzTemplateSpec', 'Set-AzTemplateSpec', 'Export-AzTemplateSpec', 
               'Remove-AzTemplateSpec', 'Publish-AzBicepModule', 
               'Get-AzResourceManagementPrivateLink', 
               'Remove-AzResourceManagementPrivateLink', 
               'New-AzResourceManagementPrivateLink', 
               'New-AzPrivateLinkAssociation', 'Get-AzPrivateLinkAssociation', 
               'Remove-AzPrivateLinkAssociation', 'Get-AzManagementGroupEntity', 
               'Get-AzManagementGroupNameAvailability', 
               'Get-AzTenantBackfillStatus', 'Start-AzTenantBackfill', 
               'Get-AzManagementGroupSubscription', 
               'New-AzManagementGroupHierarchySetting', 
               'Update-AzManagementGroupHierarchySetting', 
               'Get-AzManagementGroupHierarchySetting', 
               'Remove-AzManagementGroupHierarchySetting', 
               'Get-AzResourceGroupDeploymentStack', 
               'New-AzResourceGroupDeploymentStack', 
               'New-AzSubscriptionDeploymentStack', 
               'Remove-AzResourceGroupDeploymentStack', 
               'Remove-AzSubscriptionDeploymentStack', 
               'Set-AzResourceGroupDeploymentStack', 
               'Set-AzSubscriptionDeploymentStack', 
               'Get-AzSubscriptionDeploymentStack', 
               'Save-AzResourceGroupDeploymentStackTemplate', 
               'Save-AzSubscriptionDeploymentStackTemplate', 
               'Save-AzManagementGroupDeploymentStackTemplate', 
               'Set-AzManagementGroupDeploymentStack', 
               'New-AzManagementGroupDeploymentStack', 
               'Remove-AzManagementGroupDeploymentStack', 
               'Get-AzManagementGroupDeploymentStack'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = 'Get-AzResourceProviderAction', 
               'Get-AzADServicePrincipalCredential', 
               'New-AzADServicePrincipalCredential', 
               'Remove-AzADServicePrincipalCredential', 'Set-AzADApplication', 
               'Set-AzADServicePrincipal', 'Set-AzADUser', 
               'New-AzSubscriptionDeployment', 'Get-AzSubscriptionDeployment', 
               'Test-AzSubscriptionDeployment', 'Remove-AzSubscriptionDeployment', 
               'Stop-AzSubscriptionDeployment', 
               'Save-AzSubscriptionDeploymentTemplate', 
               'Get-AzSubscriptionDeploymentOperation', 
               'Get-AzSubscriptionDeploymentWhatIfResult', 
               'Set-AzPolicyAssignment', 'Set-AzPolicyDefinition', 
               'Set-AzPolicyExemption', 'Set-AzPolicySetDefinition'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Azure','ResourceManager','ARM','Provider','ResourceGroup','Deployment','ActiveDirectory','Authorization','Management','ManagementGroups','Tags'

        # A URL to the license for this module.
        LicenseUri = 'https://aka.ms/azps-license'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Azure/azure-powershell'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '* [Breaking Change] Redesigned CRUD cmdlets for PolicyAssignment, PolicyDefinition, PolicyExemption, PolicySetDefinition. Please see Az 11 migration guide https://learn.microsoft.com/en-us/powershell/azure/migrate-az-10.0.0 for more detail.
* Used utf8 encoding for reading stdout & stderr when invoking Bicep. [#23246]
* Fixed regression in ''Publish-AzBicepModule'' [Azure/bicep/12461](https://github.com/Azure/bicep/issues/12461)'

        # Prerelease string of this module
        Prerelease = 'preview'

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}


# SIG # Begin signature block
# MIInzgYJKoZIhvcNAQcCoIInvzCCJ7sCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCC/+XGPtaLqLxaT
# P+YFQQ95L3xXiKIVL9sNdI46WW7+R6CCDYUwggYDMIID66ADAgECAhMzAAADTU6R
# phoosHiPAAAAAANNMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjMwMzE2MTg0MzI4WhcNMjQwMzE0MTg0MzI4WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDUKPcKGVa6cboGQU03ONbUKyl4WpH6Q2Xo9cP3RhXTOa6C6THltd2RfnjlUQG+
# Mwoy93iGmGKEMF/jyO2XdiwMP427j90C/PMY/d5vY31sx+udtbif7GCJ7jJ1vLzd
# j28zV4r0FGG6yEv+tUNelTIsFmmSb0FUiJtU4r5sfCThvg8dI/F9Hh6xMZoVti+k
# bVla+hlG8bf4s00VTw4uAZhjGTFCYFRytKJ3/mteg2qnwvHDOgV7QSdV5dWdd0+x
# zcuG0qgd3oCCAjH8ZmjmowkHUe4dUmbcZfXsgWlOfc6DG7JS+DeJak1DvabamYqH
# g1AUeZ0+skpkwrKwXTFwBRltAgMBAAGjggGCMIIBfjAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUId2Img2Sp05U6XI04jli2KohL+8w
# VAYDVR0RBE0wS6RJMEcxLTArBgNVBAsTJE1pY3Jvc29mdCBJcmVsYW5kIE9wZXJh
# dGlvbnMgTGltaXRlZDEWMBQGA1UEBRMNMjMwMDEyKzUwMDUxNzAfBgNVHSMEGDAW
# gBRIbmTlUAXTgqoXNzcitW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8v
# d3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIw
# MTEtMDctMDguY3JsMGEGCCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDov
# L3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDEx
# XzIwMTEtMDctMDguY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIB
# ACMET8WuzLrDwexuTUZe9v2xrW8WGUPRQVmyJ1b/BzKYBZ5aU4Qvh5LzZe9jOExD
# YUlKb/Y73lqIIfUcEO/6W3b+7t1P9m9M1xPrZv5cfnSCguooPDq4rQe/iCdNDwHT
# 6XYW6yetxTJMOo4tUDbSS0YiZr7Mab2wkjgNFa0jRFheS9daTS1oJ/z5bNlGinxq
# 2v8azSP/GcH/t8eTrHQfcax3WbPELoGHIbryrSUaOCphsnCNUqUN5FbEMlat5MuY
# 94rGMJnq1IEd6S8ngK6C8E9SWpGEO3NDa0NlAViorpGfI0NYIbdynyOB846aWAjN
# fgThIcdzdWFvAl/6ktWXLETn8u/lYQyWGmul3yz+w06puIPD9p4KPiWBkCesKDHv
# XLrT3BbLZ8dKqSOV8DtzLFAfc9qAsNiG8EoathluJBsbyFbpebadKlErFidAX8KE
# usk8htHqiSkNxydamL/tKfx3V/vDAoQE59ysv4r3pE+zdyfMairvkFNNw7cPn1kH
# Gcww9dFSY2QwAxhMzmoM0G+M+YvBnBu5wjfxNrMRilRbxM6Cj9hKFh0YTwba6M7z
# ntHHpX3d+nabjFm/TnMRROOgIXJzYbzKKaO2g1kWeyG2QtvIR147zlrbQD4X10Ab
# rRg9CpwW7xYxywezj+iNAc+QmFzR94dzJkEPUSCJPsTFMIIHejCCBWKgAwIBAgIK
# YQ6Q0gAAAAAAAzANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlm
# aWNhdGUgQXV0aG9yaXR5IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEw
# OTA5WjB+MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYD
# VQQDEx9NaWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG
# 9w0BAQEFAAOCAg8AMIICCgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+la
# UKq4BjgaBEm6f8MMHt03a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc
# 6Whe0t+bU7IKLMOv2akrrnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4D
# dato88tt8zpcoRb0RrrgOGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+
# lD3v++MrWhAfTVYoonpy4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nk
# kDstrjNYxbc+/jLTswM9sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6
# A4aN91/w0FK/jJSHvMAhdCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmd
# X4jiJV3TIUs+UsS1Vz8kA/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL
# 5zmhD+kjSbwYuER8ReTBw3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zd
# sGbiwZeBe+3W7UvnSSmnEyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3
# T8HhhUSJxAlMxdSlQy90lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS
# 4NaIjAsCAwEAAaOCAe0wggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRI
# bmTlUAXTgqoXNzcitW2oynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAL
# BgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBD
# uRQFTuHqp8cx0SOJNDBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jv
# c29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3JsMF4GCCsGAQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3J0MIGfBgNVHSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEF
# BQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1h
# cnljcHMuaHRtMEAGCCsGAQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkA
# YwB5AF8AcwB0AGEAdABlAG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn
# 8oalmOBUeRou09h0ZyKbC5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7
# v0epo/Np22O/IjWll11lhJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0b
# pdS1HXeUOeLpZMlEPXh6I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/
# KmtYSWMfCWluWpiW5IP0wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvy
# CInWH8MyGOLwxS3OW560STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBp
# mLJZiWhub6e3dMNABQamASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJi
# hsMdYzaXht/a8/jyFqGaJ+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYb
# BL7fQccOKO7eZS/sl/ahXJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbS
# oqKfenoi+kiVH6v7RyOA9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sL
# gOppO6/8MO0ETI7f33VtY5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtX
# cVZOSEXAQsmbdlsKgEhr/Xmfwb1tbWrJUnMTDXpQzTGCGZ8wghmbAgEBMIGVMH4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01p
# Y3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTECEzMAAANNTpGmGiiweI8AAAAA
# A00wDQYJYIZIAWUDBAIBBQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIOTb
# vIFMhwJt0k6Q0wb6071g4iSRS2AdS+kIe7naqU5dMEIGCisGAQQBgjcCAQwxNDAy
# oBSAEgBNAGkAYwByAG8AcwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20wDQYJKoZIhvcNAQEBBQAEggEAfx6wUvTzPw9CbIIePNKD33ZR7uAVgOJzWFtv
# hcwcAXB24iIjFPa1FLDPoh/z5Li4oc7LMXAd3ua8T07pDpCNC+4zE1XHSyJaYEIx
# 0LPVzA7pL4A9jYge2RU6+2UIYbEnk8IJNgVS9bD+YHkG468mvQZkNAHh59pniUon
# R4fVlbs/EHtDMAJ5+wzoBDPGv4Xxkd2In8IEouiIw28F4qnp8G9IM8zh3aBs16w+
# qcYoieW5QKlwXZoogt0kqDWffS9gTCkgd2X6uyTp45pT8PN+qd/P4Sj5BIv2BXfQ
# P6g+CexiIbC/0zIdYCdn46UqinaiZEjdbRr9RZwH+xX6LMYQa6GCFykwghclBgor
# BgEEAYI3AwMBMYIXFTCCFxEGCSqGSIb3DQEHAqCCFwIwghb+AgEDMQ8wDQYJYIZI
# AWUDBAIBBQAwggFZBgsqhkiG9w0BCRABBKCCAUgEggFEMIIBQAIBAQYKKwYBBAGE
# WQoDATAxMA0GCWCGSAFlAwQCAQUABCC1hFFHh4u39Gcfyqf4iue55EaRGAoZTp8t
# L98/Jw/bVwIGZV3rDZ3jGBMyMDIzMTEyNzA3MjIxNC40ODhaMASAAgH0oIHYpIHV
# MIHSMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQL
# EyRNaWNyb3NvZnQgSXJlbGFuZCBPcGVyYXRpb25zIExpbWl0ZWQxJjAkBgNVBAsT
# HVRoYWxlcyBUU1MgRVNOOjJBRDQtNEI5Mi1GQTAxMSUwIwYDVQQDExxNaWNyb3Nv
# ZnQgVGltZS1TdGFtcCBTZXJ2aWNloIIReDCCBycwggUPoAMCAQICEzMAAAHenkie
# lp8oRD0AAQAAAd4wDQYJKoZIhvcNAQELBQAwfDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAg
# UENBIDIwMTAwHhcNMjMxMDEyMTkwNzEyWhcNMjUwMTEwMTkwNzEyWjCB0jELMAkG
# A1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQx
# HjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9z
# b2Z0IElyZWxhbmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMg
# VFNTIEVTTjoyQUQ0LTRCOTItRkEwMTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgU2VydmljZTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALSB
# 9ByF9UIDhA6xFrOniw/xsDl8sSi9rOCOXSSO4VMQjnNGAo5VHx0iijMEMH9LY2SU
# IBkVQS0Ml6kR+TagkUPbaEpwjhQ1mprhRgJT/jlSnic42VDAo0en4JI6xnXoAoWo
# KySY8/ROIKdpphgI7OJb4XHk1P3sX2pNZ32LDY1ktchK1/hWyPlblaXAHRu0E3yn
# vwrS8/bcorANO6DjuysyS9zUmr+w3H3AEvSgs2ReuLj2pkBcfW1UPCFudLd7IPZ2
# RC4odQcEPnY12jypYPnS6yZAs0pLpq0KRFUyB1x6x6OU73sudiHON16mE0l6LLT9
# OmGo0S94Bxg3N/3aE6fUbnVoemVc7FkFLum8KkZcbQ7cOHSAWGJxdCvo5OtUtRdS
# qf85FklCXIIkg4sm7nM9TktUVfO0kp6kx7mysgD0Qrxx6/5oaqnwOTWLNzK+BCi1
# G7nUD1pteuXvQp8fE1KpTjnG/1OJeehwKNNPjGt98V0BmogZTe3SxBkOeOQyLA++
# 5Hyg/L68pe+DrZoZPXJaGU/iBiFmL+ul/Oi3d83zLAHlHQmH/VGNBfRwP+ixvqhy
# k/EebwuXVJY+rTyfbRfuh9n0AaMhhNxxg6tGKyZS4EAEiDxrF9mAZEy8e8rf6dlK
# IX5d3aQLo9fDda1ZTOw+XAcAvj2/N3DLVGZlHnHlAgMBAAGjggFJMIIBRTAdBgNV
# HQ4EFgQUazAmbxseaapgdxzK8Os+naPQEsgwHwYDVR0jBBgwFoAUn6cVXQBeYl2D
# 9OXSZacbUzUZ6XIwXwYDVR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3Nv
# ZnQuY29tL3BraW9wcy9jcmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUy
# MDIwMTAoMSkuY3JsMGwGCCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDov
# L3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1l
# LVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADAWBgNVHSUB
# Af8EDDAKBggrBgEFBQcDCDAOBgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQELBQAD
# ggIBAOKUwHsXDacGOvUIgs5HDgPs0LZ1qyHS6C6wfKlLaD36tZfbWt1x+GMiazSu
# y+GsxiVHzkhMW+FqK8gruLQWN/sOCX+fGUgT9LT21cRIpcZj4/ZFIvwtkBcsCz1X
# EUsXYOSJUPitY7E8bbldmmhYZ29p+XQpIcsG/q+YjkqBW9mw0ru1MfxMTQs9MTDi
# D28gAVGrPA3NykiSChvdqS7VX+/LcEz9Ubzto/w28WA8HOCHqBTbDRHmiP7MIj+S
# QmI9VIayYsIGRjvelmNa0OvbU9CJSz/NfMEgf2NHMZUYW8KqWEjIjPfHIKxWlNMY
# huWfWRSHZCKyIANA0aJL4soHQtzzZ2MnNfjYY851wHYjGgwUj/hlLRgQO5S30Zx7
# 8GqBKfylp25aOWJ/qPhC+DXM2gXajIXbl+jpGcVANwtFFujCJRdZbeH1R+Q41Fjg
# Bg4m3OTFDGot5DSuVkQgjku7pOVPtldE46QlDg/2WhPpTQxXH64sP1GfkAwUtt6r
# rZM/PCwRG6girYmnTRLLsicBhoYLh+EEFjVviXAGTk6pnu8jx/4WPWu0jsz7yFzg
# 82/FMqCk9wK3LvyLAyDHN+FxbHAxtgwad7oLQPM0WGERdB1umPCIiYsSf/j79EqH
# doNwQYROVm+ZX10RX3n6bRmAnskeNhi0wnVaeVogLMdGD+nqMIIHcTCCBVmgAwIB
# AgITMwAAABXF52ueAptJmQAAAAAAFTANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UE
# BhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAc
# BgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0
# IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IDIwMTAwHhcNMjEwOTMwMTgyMjI1
# WhcNMzAwOTMwMTgzMjI1WjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
# Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
# cmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDCC
# AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOThpkzntHIhC3miy9ckeb0O
# 1YLT/e6cBwfSqWxOdcjKNVf2AX9sSuDivbk+F2Az/1xPx2b3lVNxWuJ+Slr+uDZn
# hUYjDLWNE893MsAQGOhgfWpSg0S3po5GawcU88V29YZQ3MFEyHFcUTE3oAo4bo3t
# 1w/YJlN8OWECesSq/XJprx2rrPY2vjUmZNqYO7oaezOtgFt+jBAcnVL+tuhiJdxq
# D89d9P6OU8/W7IVWTe/dvI2k45GPsjksUZzpcGkNyjYtcI4xyDUoveO0hyTD4MmP
# frVUj9z6BVWYbWg7mka97aSueik3rMvrg0XnRm7KMtXAhjBcTyziYrLNueKNiOSW
# rAFKu75xqRdbZ2De+JKRHh09/SDPc31BmkZ1zcRfNN0Sidb9pSB9fvzZnkXftnIv
# 231fgLrbqn427DZM9ituqBJR6L8FA6PRc6ZNN3SUHDSCD/AQ8rdHGO2n6Jl8P0zb
# r17C89XYcz1DTsEzOUyOArxCaC4Q6oRRRuLRvWoYWmEBc8pnol7XKHYC4jMYcten
# IPDC+hIK12NvDMk2ZItboKaDIV1fMHSRlJTYuVD5C4lh8zYGNRiER9vcG9H9stQc
# xWv2XFJRXRLbJbqvUAV6bMURHXLvjflSxIUXk8A8FdsaN8cIFRg/eKtFtvUeh17a
# j54WcmnGrnu3tz5q4i6tAgMBAAGjggHdMIIB2TASBgkrBgEEAYI3FQEEBQIDAQAB
# MCMGCSsGAQQBgjcVAgQWBBQqp1L+ZMSavoKRPEY1Kc8Q/y8E7jAdBgNVHQ4EFgQU
# n6cVXQBeYl2D9OXSZacbUzUZ6XIwXAYDVR0gBFUwUzBRBgwrBgEEAYI3TIN9AQEw
# QTA/BggrBgEFBQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9E
# b2NzL1JlcG9zaXRvcnkuaHRtMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBkGCSsGAQQB
# gjcUAgQMHgoAUwB1AGIAQwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/
# MB8GA1UdIwQYMBaAFNX2VsuP6KJcYmjRPZSQW9fOmhjEMFYGA1UdHwRPME0wS6BJ
# oEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01p
# Y1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYB
# BQUHMAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljUm9v
# Q2VyQXV0XzIwMTAtMDYtMjMuY3J0MA0GCSqGSIb3DQEBCwUAA4ICAQCdVX38Kq3h
# LB9nATEkW+Geckv8qW/qXBS2Pk5HZHixBpOXPTEztTnXwnE2P9pkbHzQdTltuw8x
# 5MKP+2zRoZQYIu7pZmc6U03dmLq2HnjYNi6cqYJWAAOwBb6J6Gngugnue99qb74p
# y27YP0h1AdkY3m2CDPVtI1TkeFN1JFe53Z/zjj3G82jfZfakVqr3lbYoVSfQJL1A
# oL8ZthISEV09J+BAljis9/kpicO8F7BUhUKz/AyeixmJ5/ALaoHCgRlCGVJ1ijbC
# HcNhcy4sa3tuPywJeBTpkbKpW99Jo3QMvOyRgNI95ko+ZjtPu4b6MhrZlvSP9pEB
# 9s7GdP32THJvEKt1MMU0sHrYUP4KWN1APMdUbZ1jdEgssU5HLcEUBHG/ZPkkvnNt
# yo4JvbMBV0lUZNlz138eW0QBjloZkWsNn6Qo3GcZKCS6OEuabvshVGtqRRFHqfG3
# rsjoiV5PndLQTHa1V1QJsWkBRH58oWFsc/4Ku+xBZj1p/cvBQUl+fpO+y/g75LcV
# v7TOPqUxUYS8vwLBgqJ7Fx0ViY1w/ue10CgaiQuPNtq6TPmb/wrpNPgkNWcr4A24
# 5oyZ1uEi6vAnQj0llOZ0dFtq0Z4+7X6gMTN9vMvpe784cETRkPHIqzqKOghif9lw
# Y1NNje6CbaUFEMFxBmoQtB1VM1izoXBm8qGCAtQwggI9AgEBMIIBAKGB2KSB1TCB
# 0jELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1Jl
# ZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMk
# TWljcm9zb2Z0IElyZWxhbmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1U
# aGFsZXMgVFNTIEVTTjoyQUQ0LTRCOTItRkEwMTElMCMGA1UEAxMcTWljcm9zb2Z0
# IFRpbWUtU3RhbXAgU2VydmljZaIjCgEBMAcGBSsOAwIaAxUAaKBSisy4y86pl8Xy
# 22CJZExE2vOggYMwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
# Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
# cmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDAN
# BgkqhkiG9w0BAQUFAAIFAOkOWDYwIhgPMjAyMzExMjcwNzUwMTRaGA8yMDIzMTEy
# ODA3NTAxNFowdDA6BgorBgEEAYRZCgQBMSwwKjAKAgUA6Q5YNgIBADAHAgEAAgIT
# CjAHAgEAAgIRLTAKAgUA6Q+ptgIBADA2BgorBgEEAYRZCgQCMSgwJjAMBgorBgEE
# AYRZCgMCoAowCAIBAAIDB6EgoQowCAIBAAIDAYagMA0GCSqGSIb3DQEBBQUAA4GB
# AE3T8468E+1eZXl5uE7KWlIw4cMyBwMiZMkSBYJ6boiXewcDA+W3MlN/6pFZHaQy
# cpxje7PfUYtXCCyVMZmzE0HfNILAuSmQNDn0PMbAU3rfx+lZxkmEkJP5ynABRRje
# /L+QrhlMlUul6XpYobQ/199mkrx6tLmTjPqLPCQtfeqVMYIEDTCCBAkCAQEwgZMw
# fDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1Jl
# ZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMd
# TWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMAAAHenkielp8oRD0AAQAA
# Ad4wDQYJYIZIAWUDBAIBBQCgggFKMBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRAB
# BDAvBgkqhkiG9w0BCQQxIgQg4U80Rj6tykl8g9xoFpjpTPGKqo7jaHb71fNVzqYk
# 2z8wgfoGCyqGSIb3DQEJEAIvMYHqMIHnMIHkMIG9BCCOPiOfDcFeEBBJAn/mC3Mg
# rT5w/U2z81LYD44Hc34dezCBmDCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQI
# EwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3Nv
# ZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBD
# QSAyMDEwAhMzAAAB3p5InpafKEQ9AAEAAAHeMCIEIHe6JMYtHgQFoMvxUV4n/KM4
# aXw/V4NrHV7Wyb/VKLzxMA0GCSqGSIb3DQEBCwUABIICABbwE/9mN6TtUQ3kESLG
# mWc6LTr8KqTR3m2lSMA7lQrR9820Rwt9NM9uWOr3Q5XoNlbYTH5akZCYkKrpResZ
# baJryuEn8b/P5PBwF1C5JzMzFrPQC7q4wwEs9hOZSAvmk7idmhR+khVwx7fCE776
# GthI333qzM/oLPbL6Vl7htjBJfPE+YdhnLcjs2/pMRDYtxBvJY16RKcwimwOh48Q
# 8yk/tunsKKa77FKnwZ6LD/ZsXNkB03lq/ts1AkLS7Vp66cPqh27ta8v2qOaiZA6t
# sT3NmvPLUd11OBCwTsu1N+KNWSxo//e7yhTWl/KruRf52OfvQhAkc95vW9n2Ksnu
# JJQOTV/Io7JSIruWIKCOWQgL6gET3WzabuEKhaETDu4ecpeI6ynJHp0wQtQzqBKD
# c5SGrcrPFHpmBLmz4qWQOT6nQRB62O6WjiIrDXAV4LT8V/SzDLKiBU88oP8Nrrrk
# vzKVnKb1nJ35Ulm9fhdsdbuMMFuRTjdNDEbH6mV5O8tk/+z5kMh9iuUp9sjzyeBL
# VGWHNkaqUjbZroTiRukJFVDJonVs+BGdpw0F+CLsr707webvlJ/hMNoQSHi7DEi5
# qNf7/W9ojd+pbJTGNnyE0joHmzvHV9qHQ3eei0WytRXQy4GdYBw63si44hPF7Opk
# F6aSAepFmOWdur9QPKs5sKqZ
# SIG # End signature block
