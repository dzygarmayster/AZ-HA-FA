
# ----------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Gets policy assignments.
.Description
The **Get-AzPolicyAssignment** cmdlet gets all policy assignments or particular assignments.
Identify a policy assignment to get by name and scope or by ID.
.Notes
## RELATED LINKS

[New-AzPolicyAssignment](./New-AzPolicyAssignment.md)

[Remove-AzPolicyAssignment](./Remove-AzPolicyAssignment.md)

[Update-AzPolicyAssignment](./Update-AzPolicyAssignment.md)
.Link
https://learn.microsoft.com/powershell/module/az.resources/get-azpolicyassignment
#>
function Get-AzPolicyAssignment {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.Policy.Models.Api20220601.IPolicyAssignment])]
[CmdletBinding(DefaultParameterSetName='Default')]
param(
    [Parameter(ParameterSetName='Name', Mandatory, ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Alias('PolicyAssignmentName')]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The name of the policy assignment to get.
    ${Name},

    [Parameter(ParameterSetName='Name', ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='PolicyDefinitionId', ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='IncludeDescendent', ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='Scope', Mandatory, ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The scope of the policy assignment.
    # Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}'), resource group (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}', or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'
    ${Scope},

    [Parameter(ParameterSetName='Id', Mandatory, ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Alias('PolicyAssignmentId')]
    [Alias('ResourceId')]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The ID of the policy assignment to get.
    # Use the format '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'.
    ${Id},

    [Parameter(ParameterSetName='PolicyDefinitionId', Mandatory, ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # Get all policy assignments that target the given policy definition [fully qualified] ID.
    ${PolicyDefinitionId},

    [Parameter(ParameterSetName='IncludeDescendent', Mandatory, ValueFromPipelineByPropertyName)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.Management.Automation.SwitchParameter]
    # Get all policy assignments that target the given policy definition [fully qualified] ID.
    ${IncludeDescendent},

    # This switch is implemented and working, but confusing, since -Top is a misleading name. Due to backend implementation
    # of $top, this parameter should actually be called -Pagesize. Addressing this issue is beyond the scope of the initial
    # port to autorest: we will address this in the future and hide the parameter for now to avoid future backcompat complexity.
    [Parameter(ParameterSetName='Default', ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='Scope', ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='PolicyDefinitionId', ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='IncludeDescendent', ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='Top', Mandatory, ValueFromPipelineByPropertyName)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Query')]
    [System.Int32]
    # Maximum number of records to return.
    # When -Top is not provided, this cmdlet will return 500 or fewer records.
    [Parameter(DontShow)]
    ${Top},

    [Parameter()]
    [System.Management.Automation.SwitchParameter]
    # Causes cmdlet to return artifacts using legacy format placing policy-specific properties in a property bag object.
    ${BackwardCompatible} = $false,

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Query')]
    [System.String]
    # The filter to apply on the operation.
    # Valid values for $filter are: 'atScope()', 'atExactScope()' or 'policyDefinitionId eq '{value}''.
    # If $filter is not provided, no filtering is performed.
    # If $filter=atScope() is provided, the returned list only includes all policy assignments that apply to the scope, which is everything in the unfiltered list except those applied to sub scopes contained within the given scope.
    # If $filter=atExactScope() is provided, the returned list only includes all policy assignments that at the given scope.
    # If $filter=policyDefinitionId eq '{value}' is provided, the returned list includes all policy assignments of the policy definition whose id is {value}.
    ${Filter},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The name of the resource group that contains policy assignments.
    ${ResourceGroupName},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String[]]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The parent resource path.
    # Use empty string if there is none.
    ${ParentResourcePath},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The name of the resource.
    ${ResourceName},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The namespace of the resource provider.
    # For example, the namespace of a virtual machine is Microsoft.Compute (from Microsoft.Compute/virtualMachines)
    ${ResourceProviderNamespace},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [System.String]
    # The resource type name.
    # For example the type name of a web app is 'sites' (from Microsoft.Web/sites).
    ${ResourceType},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Models.IPolicyIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The DefaultProfile parameter is not functional.
    # Use the SubscriptionId parameter when available if executing the cmdlet against a different subscription.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    # turn on console debug messages
    $writeln = ($PSCmdlet.MyInvocation.BoundParameters.Debug -as [bool]) -or ($PSCmdlet.MyInvocation.BoundParameters.Verbose -as [bool])

    if ($writeln) {
        Write-Host -ForegroundColor Cyan "begin:Get-AzPolicyAssignment(" $PSBoundParameters ") - (ParameterSet: $($PSCmdlet.ParameterSetName))"
    }

    # make mapping table
    $mapping = @{
        Get = 'Az.Policy.private\Get-AzPolicyAssignment_Get';
        Get1 = 'Az.Policy.private\Get-AzPolicyAssignment_Get1';
        GetViaIdentity = 'Az.Policy.private\Get-AzPolicyAssignment_GetViaIdentity';
        GetViaIdentity1 = 'Az.Policy.private\Get-AzPolicyAssignment_GetViaIdentity1';
        List = 'Az.Policy.private\Get-AzPolicyAssignment_List';
        List1 = 'Az.Policy.private\Get-AzPolicyAssignment_List1';
        List2 = 'Az.Policy.private\Get-AzPolicyAssignment_List2';
        List3 = 'Az.Policy.private\Get-AzPolicyAssignment_List3';
    }
}

process {
    if ($writeln) {
        Write-Host -ForegroundColor Cyan "process:Get-AzPolicyAssignment(" $PSBoundParameters ") - (ParameterSet: $($PSCmdlet.ParameterSetName))"
    }

    $calledParameters = $PSBoundParameters

    # SubscriptionId is autorest-generated and mandatory so gets populated with default value.
    # This customized cmdlet doesn't allow/use it, so we must remove it, otherwise the parameter set is broken.
    $null = $calledParameters.Remove('SubscriptionId')

    if ($Name) {
        $calledParameterSet = 'Get'
        $calledParameters.NameInternal = $Name

        if (!$Scope) {
            $Scope = "/subscriptions/$($(Get-AzContext).Subscription.Id)"
        }

        $calledParameters.ScopeInternal = $Scope
    }
    elseif ($Id) {
        $calledParameterSet = 'Get1'
        $calledParameters.IdInternal = $Id
    }
    else {
        # set up filter values for list case
        if ($PolicyDefinitionId) {
            $calledParameters.Filter = "policyDefinitionId eq '$($PolicyDefinitionId)'"
        }
        elseif (!$IncludeDescendent) {
            $calledParameters.Filter = 'atScope()'
        }

        $calledParameterSet = 'List3'

        if ($Scope) {
            $resolved = ResolvePolicyAssignment $null $Scope $null
            switch ($resolved.ScopeType) {
                'mgName' {
                    if ($IncludeDescendent) {
                        throw 'The -IncludeDescendent switch is not supported for management group scopes.'
                    }

                    $calledParameterSet = 'List2'
                    $calledParameters.ManagementGroupId = $resolved.ManagementGroupName
                }
                'subId' {
                    $calledParameters.SubscriptionId = @($resolved.SubscriptionId)
                }
                'rgname' {
                    $calledParameterSet = 'List'
                    $calledParameters.SubscriptionId = @($resolved.SubscriptionId)
                    $calledParameters.ResourceGroupName = $resolved.ResourceGroupName
                }
                'resource' {
                    $resourceId = $resolved.Scope
                    $parts = ($resourceId -split '/')
                    $first = 1
                    $last = $parts.Length - 2
                    $calledParameterSet = 'List1'
                    $calledParameters.ResourceProviderNamespace = $parts[0]
                    $calledParameters.ResourceName = $parts[$parts.Length-1]
                    $calledParameters.ResourceType = [System.String]::Join('/', $parts[$first..$last])
                    $calledParameters.SubscriptionId = @($resolved.SubscriptionId)
                    $calledParameters.ResourceGroupName = $resolved.ResourceGroupName
                }
                'none' {
                    # This will fail, but return a helpful message
                    $calledParameterSet = 'Get1'
                    $calledParameters = @{ IdInternal = $resolved.Scope }
                }
            }
        }
        else {
            $calledParameters.SubscriptionId = @((Get-AzContext).Subscription.Id)
        }
    }

    $null = $calledParameters.Remove('Name')
    $null = $calledParameters.Remove('Scope')
    $null = $calledParameters.Remove('Id')
    $null = $calledParameters.Remove('PolicyDefinitionId')
    $null = $calledParameters.Remove('IncludeDescendent')
    $null = $calledParameters.Remove('BackwardCompatible')

    if ($writeln) {
        Write-Host -ForegroundColor Blue -> $mapping[$calledParameterSet]'(' $calledParameters ')'
    }

    $cmdInfo = Get-Command -Name $mapping[$calledParameterSet]
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.Runtime.MessageAttributeHelper]::ProcessCustomAttributesAtRuntime($cmdInfo, $MyInvocation, $parameterSet, $PSCmdlet)
    $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$calledParameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
    $scriptCmd = {& $wrappedCmd @calledParameters}
    $object = Invoke-Command -ScriptBlock $scriptCmd

    foreach ($item in $object) {
        # add property bag for backward compatibility with previous SDK cmdlets
        if ($BackwardCompatible) {
            $propertyBag = @{
                Description = $item.Description;
                DisplayName = $item.DisplayName;
                EnforcementMode = $item.EnforcementMode;
                Metadata = (ConvertObjectToPSObject $item.Metadata);
                NonComplianceMessages = (ConvertObjectToPSObject $item.NonComplianceMessage);
                NotScopes = (ConvertObjectToPSObject $item.NotScope);
                Parameters = (ConvertObjectToPSObject $item.Parameter);
                PolicyDefinitionId = $item.PolicyDefinitionId;
                Scope = $item.Scope
            }

            $identity = @{
                IdentityType = $item.IdentityType;
                PrincipalId = $item.IdentityPrincipalId;
                TenantId = $item.IdentityTenantId;
                UserAssignedIdentities = [PSCustomObject]$item.IdentityUserAssignedIdentity
            }

            $item | Add-Member -MemberType NoteProperty -Name 'Identity' -Value ([PSCustomObject]($identity))
            $item | Add-Member -MemberType NoteProperty -Name 'Properties' -Value ([PSCustomObject]($propertyBag))
            $item | Add-Member -MemberType NoteProperty -Name 'ResourceId' -Value $item.Id
            $item | Add-Member -MemberType NoteProperty -Name 'ResourceName' -Value $item.Name
            $item | Add-Member -MemberType NoteProperty -Name 'ResourceType' -Value $item.Type
            $item | Add-Member -MemberType NoteProperty -Name 'PolicyAssignmentId' -Value $item.Id
        }

        $item | Add-Member -MemberType NoteProperty -Name 'Metadata' -Value (ConvertObjectToPSObject $item.Metadata) -Force
        $item | Add-Member -MemberType NoteProperty -Name 'NonComplianceMessage' -Value (ConvertObjectToPSObject $item.NonComplianceMessage) -Force
        $item | Add-Member -MemberType NoteProperty -Name 'NotScope' -Value (ConvertObjectToPSObject $item.NotScope) -Force
        $item | Add-Member -MemberType NoteProperty -Name 'Parameter' -Value (ConvertObjectToPSObject $item.Parameter) -Force
        $PSCmdlet.WriteObject($item)
    }
}

end {
} 
}

# SIG # Begin signature block
# MIIoOwYJKoZIhvcNAQcCoIIoLDCCKCgCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBXGl6KM9wDYRCT
# hRmlYh4bX0afu5YQBI0q83QJ9756OKCCDYUwggYDMIID66ADAgECAhMzAAADTU6R
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
# cVZOSEXAQsmbdlsKgEhr/Xmfwb1tbWrJUnMTDXpQzTGCGgwwghoIAgEBMIGVMH4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01p
# Y3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTECEzMAAANNTpGmGiiweI8AAAAA
# A00wDQYJYIZIAWUDBAIBBQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIDco
# QkDWfSmb5hBrffmH6NhXMNE/oU2xDOmlLzn/k7ifMEIGCisGAQQBgjcCAQwxNDAy
# oBSAEgBNAGkAYwByAG8AcwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20wDQYJKoZIhvcNAQEBBQAEggEAufNFwNACHKcrhQduBtQU77sL7E4nSIuRkzN9
# lO0adcIuKhHEi6VqPq+a2Qy0KJbIraH11v3MoPB4F01kk9poISjAV0mndIEJYZd2
# 1n+2IwcHxoRgq0gIpYlI0K8eA3iwUffmzyMssDY3XEqT27/uXC+yQdTUCQIjnmY1
# R7dZFM3s1sY5tPSBzymXplwHDDMhH3gSUjZ0ldWZN1N+gdCtrUKn/o+0OaupEZOp
# 03vTSYZ6RB7xpx94K/2AqLzyMlA84H7Bd4Ui98JkuYSXmBU9vsV+I3OURaVhL1Jh
# nOk3Fdsw7knoqKXclvy3+Yt0K5qMHErmJz5pXS7KIbEwKXEfKKGCF5YwgheSBgor
# BgEEAYI3AwMBMYIXgjCCF34GCSqGSIb3DQEHAqCCF28wghdrAgEDMQ8wDQYJYIZI
# AWUDBAIBBQAwggFRBgsqhkiG9w0BCRABBKCCAUAEggE8MIIBOAIBAQYKKwYBBAGE
# WQoDATAxMA0GCWCGSAFlAwQCAQUABCDvtzSOwP/yp22MrV8qR9kh60Savm0EUvKH
# oN8bcoUVoQIGZVbHppnFGBIyMDIzMTEyNzA2MzExOS45MVowBIACAfSggdGkgc4w
# gcsxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdS
# ZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJTAjBgNVBAsT
# HE1pY3Jvc29mdCBBbWVyaWNhIE9wZXJhdGlvbnMxJzAlBgNVBAsTHm5TaGllbGQg
# VFNTIEVTTjpBMDAwLTA1RTAtRDk0NzElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgU2VydmljZaCCEe0wggcgMIIFCKADAgECAhMzAAAB0HcIqu+jF8bdAAEA
# AAHQMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEw
# MB4XDTIzMDUyNTE5MTIxNFoXDTI0MDIwMTE5MTIxNFowgcsxCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJTAjBgNVBAsTHE1pY3Jvc29mdCBBbWVy
# aWNhIE9wZXJhdGlvbnMxJzAlBgNVBAsTHm5TaGllbGQgVFNTIEVTTjpBMDAwLTA1
# RTAtRDk0NzElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZTCC
# AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAN8yV+ffl+8zRcBRKYjmqIbR
# TE+LbkeRLIGDOTfOlg7fXV3U4QQXPRCkArbezV0kWuMHmAP5IzDnPoTDELgKtdT0
# ppDhY0eoeuFZ+2mCjcyQl7H1+uY70yV1R+NQbnqwhbphUXpiNf72tPUkN0IMdujm
# dmJqwyKAYprAZvYeoPv+SNFHrtG9WHtDidq0BW7jpl/kwu+JHTE3lw0bbTHAHCC2
# 1pgSTleVQtoEfk6dfPZ5agjH5KMM7sG3kG4AFZjxK+ZFB8HJPZymkTNOO39+zTGn
# gHVwAdUPCUbBm6/1F9zed13GAWsoDwxYdskXT5pZRRggFHwXLaC4VUegd47N7six
# vK9GtrH//zeBiqjxzln/X+7uSMtxOCKmLJnxcRGwsQQInmjHUEEtjoCOZuADMN02
# XYt56P6oht0Gv9JS8oQL5fDjGMUw5NRVYpZ6a3aSHCd1R8E1Hs3O7XP0vRa/tMBj
# +/6/qk2EB6iE8wIUlz5qTq4wPxMpLNYWPDloAOSYP2Ya4LzrK9IqQgjgxrLOhR2x
# 5PSd+TxjR8+O13DZad6OXrMse5hfBwNq7Y7UMy6iJ501WNMXftQSZhP6jEL84VdQ
# Y8MRC323OBtH2Dwcu1R8R5Y6w4QPnGBvmvDJ+8iyzsf9x0cVwiIhzPNCBiewvIQZ
# 6mhkOQqFIxHl4IHopy/9AgMBAAGjggFJMIIBRTAdBgNVHQ4EFgQUM+EBhZLSgD6U
# 60hN+Mm3KXSSdFEwHwYDVR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXwYD
# VR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9j
# cmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3JsMGwG
# CCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIw
# MjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcD
# CDAOBgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQELBQADggIBAJeH5yQKRloDTpI1
# b6rG1L2AdCnjHsb6B2KSeAoi0Svyi2RciuZY9itqtFYGVj3WWoaKKUfIiVneI0FR
# to0SZooAYxnlhxLshlQo9qrWNTSazKX7yiDS30L9nbr5q3He+yEesVC5KDBMdlWn
# O/uTwJicFijF2EjW4aGofn3maou+0yzEQ3/WyjtT5vdTosKvLm7DBzPn6Pw6PQZR
# fdv6JmD4CzTFM3pPRBrwE15z8vBzKpg0RoyRbZUAquaG9Yfw4INNxeA42ecAFAcF
# 9cr98sBscUZLVc062vrb+JocEYCSsIaXoGLw9/Czp+z7D6wT2veFf1WDSCxEygdG
# 4xqJeysaYay5icufcDBOC4xq3D1HxTm8m1ZKW7UIU7k/QsS9BCIxnXaxBKxACQ0N
# Oz2tONU2OMhSChnpc8zGVw8gNyPHDxt95vjLjADEzZFGhZzGmTH7ogh/Yv5vuAse
# 0HFcJYnlsxbtbBQLYuW1u6tTAG/RKCOkO1sSrD+4OBYF6sJP5m3Lc1z3ruIZpCPJ
# hAfof+H1dzyyabafpWPJJHHazCdbeGvpDHrdT/Fj0cvoU2GsaIUQPtlEqufC+9e8
# xVBQgSQHsZQR43qF5jyAcu3SMtXfLMOJADxHynlgaAYBW30wTCAAk1jWIe8f/y/O
# ElJkU2Qfyy9HO07+LdO8quNvxnHCMIIHcTCCBVmgAwIBAgITMwAAABXF52ueAptJ
# mQAAAAAAFTANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgT
# Cldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29m
# dCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNh
# dGUgQXV0aG9yaXR5IDIwMTAwHhcNMjEwOTMwMTgyMjI1WhcNMzAwOTMwMTgzMjI1
# WjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDCCAiIwDQYJKoZIhvcNAQEB
# BQADggIPADCCAgoCggIBAOThpkzntHIhC3miy9ckeb0O1YLT/e6cBwfSqWxOdcjK
# NVf2AX9sSuDivbk+F2Az/1xPx2b3lVNxWuJ+Slr+uDZnhUYjDLWNE893MsAQGOhg
# fWpSg0S3po5GawcU88V29YZQ3MFEyHFcUTE3oAo4bo3t1w/YJlN8OWECesSq/XJp
# rx2rrPY2vjUmZNqYO7oaezOtgFt+jBAcnVL+tuhiJdxqD89d9P6OU8/W7IVWTe/d
# vI2k45GPsjksUZzpcGkNyjYtcI4xyDUoveO0hyTD4MmPfrVUj9z6BVWYbWg7mka9
# 7aSueik3rMvrg0XnRm7KMtXAhjBcTyziYrLNueKNiOSWrAFKu75xqRdbZ2De+JKR
# Hh09/SDPc31BmkZ1zcRfNN0Sidb9pSB9fvzZnkXftnIv231fgLrbqn427DZM9itu
# qBJR6L8FA6PRc6ZNN3SUHDSCD/AQ8rdHGO2n6Jl8P0zbr17C89XYcz1DTsEzOUyO
# ArxCaC4Q6oRRRuLRvWoYWmEBc8pnol7XKHYC4jMYctenIPDC+hIK12NvDMk2ZItb
# oKaDIV1fMHSRlJTYuVD5C4lh8zYGNRiER9vcG9H9stQcxWv2XFJRXRLbJbqvUAV6
# bMURHXLvjflSxIUXk8A8FdsaN8cIFRg/eKtFtvUeh17aj54WcmnGrnu3tz5q4i6t
# AgMBAAGjggHdMIIB2TASBgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQW
# BBQqp1L+ZMSavoKRPEY1Kc8Q/y8E7jAdBgNVHQ4EFgQUn6cVXQBeYl2D9OXSZacb
# UzUZ6XIwXAYDVR0gBFUwUzBRBgwrBgEEAYI3TIN9AQEwQTA/BggrBgEFBQcCARYz
# aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9Eb2NzL1JlcG9zaXRvcnku
# aHRtMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIA
# QwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFNX2
# VsuP6KJcYmjRPZSQW9fOmhjEMFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9jcmwu
# bWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dF8yMDEw
# LTA2LTIzLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0dHA6Ly93
# d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYt
# MjMuY3J0MA0GCSqGSIb3DQEBCwUAA4ICAQCdVX38Kq3hLB9nATEkW+Geckv8qW/q
# XBS2Pk5HZHixBpOXPTEztTnXwnE2P9pkbHzQdTltuw8x5MKP+2zRoZQYIu7pZmc6
# U03dmLq2HnjYNi6cqYJWAAOwBb6J6Gngugnue99qb74py27YP0h1AdkY3m2CDPVt
# I1TkeFN1JFe53Z/zjj3G82jfZfakVqr3lbYoVSfQJL1AoL8ZthISEV09J+BAljis
# 9/kpicO8F7BUhUKz/AyeixmJ5/ALaoHCgRlCGVJ1ijbCHcNhcy4sa3tuPywJeBTp
# kbKpW99Jo3QMvOyRgNI95ko+ZjtPu4b6MhrZlvSP9pEB9s7GdP32THJvEKt1MMU0
# sHrYUP4KWN1APMdUbZ1jdEgssU5HLcEUBHG/ZPkkvnNtyo4JvbMBV0lUZNlz138e
# W0QBjloZkWsNn6Qo3GcZKCS6OEuabvshVGtqRRFHqfG3rsjoiV5PndLQTHa1V1QJ
# sWkBRH58oWFsc/4Ku+xBZj1p/cvBQUl+fpO+y/g75LcVv7TOPqUxUYS8vwLBgqJ7
# Fx0ViY1w/ue10CgaiQuPNtq6TPmb/wrpNPgkNWcr4A245oyZ1uEi6vAnQj0llOZ0
# dFtq0Z4+7X6gMTN9vMvpe784cETRkPHIqzqKOghif9lwY1NNje6CbaUFEMFxBmoQ
# tB1VM1izoXBm8qGCA1AwggI4AgEBMIH5oYHRpIHOMIHLMQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1lcmlj
# YSBPcGVyYXRpb25zMScwJQYDVQQLEx5uU2hpZWxkIFRTUyBFU046QTAwMC0wNUUw
# LUQ5NDcxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2WiIwoB
# ATAHBgUrDgMCGgMVALy3yFPwopRf3WVTkWpE/0J+70yJoIGDMIGApH4wfDELMAkG
# A1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQx
# HjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9z
# b2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwDQYJKoZIhvcNAQELBQACBQDpDnPWMCIY
# DzIwMjMxMTI3MDE0ODA2WhgPMjAyMzExMjgwMTQ4MDZaMHcwPQYKKwYBBAGEWQoE
# ATEvMC0wCgIFAOkOc9YCAQAwCgIBAAICBZ8CAf8wBwIBAAICFA4wCgIFAOkPxVYC
# AQAwNgYKKwYBBAGEWQoEAjEoMCYwDAYKKwYBBAGEWQoDAqAKMAgCAQACAwehIKEK
# MAgCAQACAwGGoDANBgkqhkiG9w0BAQsFAAOCAQEAC/FnfroNbYusOkG4/xStzvBf
# hGiokQzyMKT44T+EvMyeIrZksBpkyt+bpo5vmXzjKid6VyavNObbuLPNCjscbKc6
# 0nJZaw2zrFoHiKN+qRYLnhZ15CyAOI4Saq3xEE88kEocF+l2ZcrQMGgY9DA9OyZK
# Vuv0CeHmZqh1xnkWK+0TKyysa3vMBguwpcT14C8n7/qEZzKlL5C1Zcd8DCIvrzV0
# Wxc2x1EFOmkFkeqWVgkFjsfJLaI76ByNo8jDskr7gRXWElfL1TtA2qa2xPVJ/Zq7
# Sr6yEkcaodb1bPM9j2Is8JFUbt8UKxKRD3Y/LgCbp5AdE/bUB+3e5WEUH808TjGC
# BA0wggQJAgEBMIGTMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9u
# MRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRp
# b24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAAB
# 0HcIqu+jF8bdAAEAAAHQMA0GCWCGSAFlAwQCAQUAoIIBSjAaBgkqhkiG9w0BCQMx
# DQYLKoZIhvcNAQkQAQQwLwYJKoZIhvcNAQkEMSIEIH3sUXv2Mf6ObFY69TbYm8S3
# BcWfhyt830Kw0Yc1fIIPMIH6BgsqhkiG9w0BCRACLzGB6jCB5zCB5DCBvQQgCJVA
# Bl+00/8x3UTZjD58Fdr3Dp+OZNnlYB6utNI/CdcwgZgwgYCkfjB8MQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQg
# VGltZS1TdGFtcCBQQ0EgMjAxMAITMwAAAdB3CKrvoxfG3QABAAAB0DAiBCDaS5db
# wJQQpRDen+YIuFh9ogzDv97qDMnIljDaxi4leDANBgkqhkiG9w0BAQsFAASCAgBO
# i3x5kEVQSEs6jZlq+pDZ+at1KyU2SNsAIN7Awm5D9Q2FTt0ncOiKEQeb17xaE1Ez
# diDaiTeZUFVCjz8Z4o0oylJNh/jbZxD/WZ4HECBFYo9oR51Xtq3GcYyF6a/prdA8
# jqMuCoPxJ5OdFFknNT+eP5yul6cccCy9BpFQxesubzWSth8pCJAke9//8LpYBHqp
# sbaLHTY1BZEWNc28ywDb7UDbIcdHAF/ExFGzTHJ2tBaXgr0PDbjqhyyCfy00rAm4
# d1y9lJWrXITHIXViG0zg7KOUUWILbtyY84ZzxlXwKP0xrT4jynX2tmoYNga5qsbZ
# aXG9x2RY1UZ1J5qTSiLN32CzNHs/57rzWVhEvfjTGvABnsTCJ9zp6HkRoLhaZTFi
# UnqW5ZZ08mXF1n9P+34Ly3x4s8F0WNyUiTo76hRolWHMOWCqgFSA/3YThDfw0AIs
# 9B3s6iLSXuiDs7dh+W0Dql3kGSoW0DPJAZMLSUi+PQ5oRuYbTtEs3e6YsmtTyY0G
# qQ/D1K1DfgzLDzLsB4bmkTxB4yc8tsGCRwPX/9yLpkEPYkN8KOAmhLLT7WD5WQww
# J951PGE/EdUjDAlr/MIaDaj6f9XSrgb0DI6RH7PzePaPqKU1eW7xZiNUWO/qockW
# wzi2JiwlPi5OiiypSakAM96kic0N3EonVTJUsO0EBg==
# SIG # End signature block
