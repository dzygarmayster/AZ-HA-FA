
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
# Code generated by Microsoft (R) AutoRest Code Generator.Changes may cause incorrect behavior and will be lost if the code
# is regenerated.
# ----------------------------------------------------------------------------------

# split policy ids into usable parts (only used internally in this file)
function parsePolicyId {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    # the resource Id of a policy definition
    param($resourceId, $typeName)

    # validate args
    if (!$resourceId) {
        throw 'parsePolicyId(resourceId, typeName) argument error: resourceId must be provided.'
    }

    if (!$typeName) {
        # extract typename
        $temp = $resourceId -split '/providers/Microsoft.Authorization/'
        $typeName = ($temp[1] -split '/')[0]
    }

    if (!$typeName) {
        throw 'parsePolicyId(resourceId, typeName) argument error: unable to find type name.'
    }

    $mark = "/providers/microsoft.authorization/$($typeName)/"
    $parts = $resourceId -split $mark
    $name = $parts[1]
    $scope = $parts[0]
    $subId = ''
    $mgName = ''
    $rgName = ''
    $type = 'none'

    if ($scope -eq '') {
        $type = 'builtin'
    }
    elseif ($scope -like '/providers/Microsoft.Management/managementGroups/*') {
        $type = 'mgname'
        $mgName = ($scope -split '/providers/Microsoft.Management/managementGroups/')[1]
    }
    elseif ($scope -like '/subscriptions/*/resourceGroups/*/*') {
        $type = 'resource'
        $temp = ($scope -split '/subscriptions/')[1]
        $temp = ($temp -split '/resourceGroups/')
        $subId = $temp[0]
        $temp = ($temp[1] -split '/providers/')
        $rgName = $temp[0]
        $resource = $temp[1]
    }
    elseif ($scope -like '/subscriptions/*/resourceGroups/*') {
        $type = 'rgname'
        $temp = ($scope -split '/subscriptions/')[1]
        $temp = ($temp -split '/resourceGroups/')
        $subId = $temp[0]
        $rgName = $temp[1]
    }
    elseif ($scope -like '/subscriptions/*') {
        $type = 'subId'
        $subId = ($scope -split '/subscriptions/')[1]
    }

    return @{
        ScopeType = $type
        SubscriptionId = $subId
        ManagementGroupName = $mgName
        ResourceGroupName = $rgName
        Resource = $resource
        Name = $name
        Scope = $scope
        TypeName = $typeName
    }
}

# split policy definition resourceId into its parts (used externally)
function ParsePolicyDefinitionId {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    # the resource Id of a policy definition
    param($ResourceId)

    parsePolicyId $ResourceId 'policyDefinitions'
}

# split policy set definition resourceId into its parts
function ParsePolicySetDefinitionId {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    # the resource Id of a policy set definition
    param($ResourceId)

    parsePolicyId $ResourceId 'policySetDefinitions'
}

# split policy assignment resourceId into its parts
function ParsePolicyAssignmentId {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    # the resource Id of a policy set definition
    param($ResourceId)

    parsePolicyId $ResourceId 'policyAssignments'
}

# split policy assignment resourceId into its parts
function ParsePolicyExemptionId {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    # the resource Id of a policy set definition
    param($resourceId)

    parsePolicyId $ResourceId 'policyExemptions'
}

# Convert input parameter value to hashtable type expected by the autorest serializers
function ConvertParameterArray
{
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param ($InputObject)

    if ($InputObject -is [array])
    {
        $collection = @(
            foreach ($object in $InputObject) { ConvertParameterArray $object }
        )

        Write-Output -NoEnumerate $collection
    }
    elseif ($InputObject -is [hashtable])
    {
        return $InputObject
    }
    elseif ($InputObject -is [PSObject])
    {
        $hash = @{}

        foreach ($property in $InputObject.PSObject.Properties)
        {
            $hash[$property.Name] = (ConvertParameterArray $property.Value).PSObject.BaseObject
        }

        $hash
    }
    else {
        return $InputObject
    }
}

# convert various input formats to policy-formatted hashtable suitable for autorest serializers
function ConvertParameterObject
{
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param ($InputObject)

    if (!$InputObject)
    {
        return $InputObject
    }
    elseif ($InputObject -is [hashtable])
    {
        # traverse hash table to ensure nested values are all processed
        $returnValue = @{}
        foreach ($key in $InputObject.Keys) {
            $returnValue[$key] = (ConvertParameterObject $InputObject[$key])
        }

        return $returnValue
    }
    elseif ($InputObject -is [array])
    {
        return @{ value = [array](ConvertParameterArray -InputObject $InputObject) }
    }
    elseif ($InputObject -is [PSObject])
    {
        $returnValue = @{}

        foreach ($property in $InputObject.PSObject.Properties) {
            $returnValue[$property.Name] = (ConvertParameterObject $property.Value).PSObject.BaseObject
        }

        return $returnValue
    }
    else {
        return @{ value = $InputObject }
    }
}

# Convert output hashtable object output by autorest serializers to PSCustomObject format for legacy support
function ConvertObjectToPSObject {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param($InputObject)

    if ($null -eq $InputObject) {
        return [PSCustomObject]$null
    }

    if ($InputObject -is [array]) {
        return ,@(foreach ($obj in $InputObject) { ConvertObjectToPSObject $obj })
    }

    if (!$InputObject.ToJsonString) {
        return [PSCustomObject]$InputObject
    }

    $jsonString = $InputObject.ToJsonString()
    if ($jsonString -is [array]) {
        $jsonString = "[$([System.String]::Join(',', $jsonString))]"
    }

    ConvertFrom-Json $jsonString -Depth 100
}

function GetPSObjectProperty {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param (
        [PSObject]$PropertyObject,
        [string]$PropertyPath
    )

    $propertyNames = $PropertyPath.Split('.')
    $tmpObject = $PropertyObject
    foreach ($propertyName in $propertyNames)
    {
        $propertyInfo = $tmpObject.PSObject.Properties[$propertyName]
        if ($propertyInfo)
        {
            if ($propertyInfo.Value -is [PSObject])
            {
                $tmpObject = [PSObject]$propertyInfo.Value
                continue
            }

            return $propertyInfo.Value
        }
    }

    return $tmpObject
}

# tests whether the given string is a Uri
function Test-Uri {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param([string]$Value)

    $uri = ''
    [System.Uri]::TryCreate($Value, [System.UriKind]::Absolute, [ref]$uri)
}

# issues a GET to the given address and returns the contents
function Get-UriContent {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param([string]$UriAddress)

    $response = Invoke-WebRequest $UriAddress -DisableKeepAlive -Method Get
    if ($response.StatusCode -eq 200) {
        return $response.Content
    }
}

# if the given string is a file path or URI, returns the contents of the file or web page
# otherwise returns the original string
function GetFileUriOrStringParameterValue {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param([string]$parameterValue)

    if (Test-Path $parameterValue) {
        Get-Content $parameterValue | Out-String
    }
    else {
        if (Test-Uri $parameterValue) {
            Get-UriContent $parameterValue
        }
        else {
            $parameterValue
        }
    }
}

function ResolvePolicyParameter {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        [string]$ParameterName,
        [string]$ParameterValue,
        [bool]$Debug = $false
    )

    $policy = GetFileUriOrStringParameterValue $ParameterValue
    if ($debug) {
        Write-Host -ForegroundColor Cyan "Parameter ${ParameterName}:" $policy
    }

    $policyParameter = ConvertFrom-Json -Depth 100 -AsHashtable $policy
    if ($policyParameter.properties) {
        return $policyParameter.properties
    } else {
        return $policyParameter
    }
}

function ResolvePolicyMetadataParameter {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        $MetadataValue,
        [bool]$Debug = $false
    )

    if ($metadataValue -is [hashtable]) {
        return $metadataValue
    }

    if ([System.String]::IsNullOrEmpty($metadataValue)) {
        return $metadataValue
    }

    $metadata = (GetFileUriOrStringParameterValue $metadataValue).Trim()
    if ($debug) {
        Write-Host -ForegroundColor Cyan Metadata: $metadata
    }

    if ($metadata -like '@{*') {
        # probably a PSCustomObject, try converting to hashtable
        return (Invoke-Expression($metadata.Replace('=',"='").Replace(';',"';").Replace('}',"'}")))
    }

    # otherwise it should be a JSON string
    if ($metadata -like '{*}') {
        return $metadata | ConvertFrom-Json -Depth 100 -AsHashtable
    }

    throw "Unrecognized metadata format - value: [$($metadataValue)], type: [$($metadataValue.GetType())]"
}

# construct the full Id of a resource given the various parts (only used internally in this file)
function resolvePolicyArtifact {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        [string]$name,
        [string]$subscriptionId,
        [string]$managementGroupName,
        [string]$id,
        [string]$typeName
    )

    $type = 'none'
    $scope = ''
    $scopeType = 'none'
    $scopeName = ''
    $fullScope = ''
    $resourceId = '<invalid>'
    $resourceGroupName = ''

    if ($id -and !$subscriptionId -and !$managementGroupName) {
        $resolved = parsePolicyId $id $typeName
        $fullScope = $resolved.Scope
        $scopeType = $resolved.ScopeType
        switch ($scopeType) {
            'subId' {
                $scope = $resolved.SubscriptionId
                $scopeName = "subscription $($scope)"
                $subscriptionId = $resolved.SubscriptionId
            }
            'mgName' {
                $scope = $resolved.ManagementGroupName
                $scopeName = "management group $($scope)"
                $managementGroupName = $resolved.ManagementGroupName
            }
            'rgname' {
                $scope = $resolved.ResourceGroupName
                $scopeName = "resource group $($scope)"
                $subscriptionId = $resolved.SubscriptionId
                $resourceGroupName = $resolved.ResourceGroupName
            }
            'resource' {
                $scope = $resolved.Resource
                $scopeName = "resource id $($scope)"
                $subscriptionId = $resolved.SubscriptionId
                $resourceGroupName = $resolved.ResourceGroupName
            }
            'none' {
                $scope = $resolved.Scope
                $scopeName = "scope $($scope)"
            }
        }

        $name = $resolved.Name
        $resourceId = $id
    } else {
        if ($name) {
            if ($managementGroupName) {
                $type = 'mgName'
                $scope = $managementGroupName
                $scopeType = 'mgName'
                $scopeName = "management group $($scope)"
                $fullScope = "/providers/Microsoft.Management/managementGroups/$($managementGroupName)"
                $resourceId = "$($fullScope)/providers/Microsoft.Authorization/$($typeName)/$($name)"
            } else {
                if (!$subscriptionId) {
                    $type = 'name'
                    $subscriptionId = (Get-AzContext).Subscription.Id
                } else {
                    $type = 'subId'
                }

                $scope = $subscriptionId
                $scopeType = 'subId'
                $scopeName = "subscription $($scope)"
                $fullScope = "/subscriptions/$($subscriptionId)"
                $resourceId = "$($fullScope)/providers/Microsoft.Authorization/$($typeName)/$($name)"
            }
        }
    }

    return @{
        Type = $type;
        Scope = $scope;
        ScopeType = $scopeType
        ScopeName = $scopeName;
        FullScope = $fullScope;
        Name = $name;
        SubscriptionId = $subscriptionId
        ResourceGroupName = $resourceGroupName
        ManagementGroupName = $managementGroupName
        ResourceId = $resourceId
    }
}

function ResolvePolicyDefinition {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        [string]$Name,
        [string]$SubscriptionId,
        [string]$ManagementGroupName,
        [string]$Id
    )

    resolvePolicyArtifact $Name $SubscriptionId $ManagementGroupName $Id 'policyDefinitions'
}

function ResolvePolicySetDefinition {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        [string]$Name,
        [string]$SubscriptionId,
        [string]$ManagementGroupName,
        [string]$Id
    )

    resolvePolicyArtifact $Name $SubscriptionId $ManagementGroupName $Id 'policySetDefinitions'
}

function ResolvePolicyAssignment {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        [string]$Name,
        [string]$Scope,
        [string]$Id
    )

    if ($Id) {
        $resourceId = $Id
    }
    elseif ($Scope) {
        $resourceId = "$($Scope)/providers/Microsoft.Authorization/policyAssignments/$($Name)"
    }
    else {
        $resourceId = "/subscriptions/$($(Get-AzContext).Subscription.Id)/providers/Microsoft.Authorization/policyAssignments/$($Name)"
    }

    resolvePolicyArtifact $null $null $null $resourceId 'policyAssignments'
}

function ResolvePolicyExemption {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        [string]$Name,
        [string]$Scope,
        [string]$Id
    )

    if ($Id) {
        $resourceId = $Id
    }
    elseif ($Scope) {
        $resourceId = "$($Scope)/providers/Microsoft.Authorization/policyExemptions/$($Name)"
    }
    else {
        $resourceId = "/subscriptions/$($(Get-AzContext).Subscription.Id)/providers/Microsoft.Authorization/policyExemptions/$($Name)"
    }

    resolvePolicyArtifact $null $null $null $resourceId 'policyExemptions'
}
# SIG # Begin signature block
# MIInwgYJKoZIhvcNAQcCoIInszCCJ68CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCTvfviHVbI8q/U
# 0HU4adrRO+C5rxBL/6FhT9ojDcGlpaCCDXYwggX0MIID3KADAgECAhMzAAADTrU8
# esGEb+srAAAAAANOMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjMwMzE2MTg0MzI5WhcNMjQwMzE0MTg0MzI5WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDdCKiNI6IBFWuvJUmf6WdOJqZmIwYs5G7AJD5UbcL6tsC+EBPDbr36pFGo1bsU
# p53nRyFYnncoMg8FK0d8jLlw0lgexDDr7gicf2zOBFWqfv/nSLwzJFNP5W03DF/1
# 1oZ12rSFqGlm+O46cRjTDFBpMRCZZGddZlRBjivby0eI1VgTD1TvAdfBYQe82fhm
# WQkYR/lWmAK+vW/1+bO7jHaxXTNCxLIBW07F8PBjUcwFxxyfbe2mHB4h1L4U0Ofa
# +HX/aREQ7SqYZz59sXM2ySOfvYyIjnqSO80NGBaz5DvzIG88J0+BNhOu2jl6Dfcq
# jYQs1H/PMSQIK6E7lXDXSpXzAgMBAAGjggFzMIIBbzAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUnMc7Zn/ukKBsBiWkwdNfsN5pdwAw
# RQYDVR0RBD4wPKQ6MDgxHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEW
# MBQGA1UEBRMNMjMwMDEyKzUwMDUxNjAfBgNVHSMEGDAWgBRIbmTlUAXTgqoXNzci
# tW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3JsMGEG
# CCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3J0
# MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIBAD21v9pHoLdBSNlFAjmk
# mx4XxOZAPsVxxXbDyQv1+kGDe9XpgBnT1lXnx7JDpFMKBwAyIwdInmvhK9pGBa31
# TyeL3p7R2s0L8SABPPRJHAEk4NHpBXxHjm4TKjezAbSqqbgsy10Y7KApy+9UrKa2
# kGmsuASsk95PVm5vem7OmTs42vm0BJUU+JPQLg8Y/sdj3TtSfLYYZAaJwTAIgi7d
# hzn5hatLo7Dhz+4T+MrFd+6LUa2U3zr97QwzDthx+RP9/RZnur4inzSQsG5DCVIM
# pA1l2NWEA3KAca0tI2l6hQNYsaKL1kefdfHCrPxEry8onJjyGGv9YKoLv6AOO7Oh
# JEmbQlz/xksYG2N/JSOJ+QqYpGTEuYFYVWain7He6jgb41JbpOGKDdE/b+V2q/gX
# UgFe2gdwTpCDsvh8SMRoq1/BNXcr7iTAU38Vgr83iVtPYmFhZOVM0ULp/kKTVoir
# IpP2KCxT4OekOctt8grYnhJ16QMjmMv5o53hjNFXOxigkQWYzUO+6w50g0FAeFa8
# 5ugCCB6lXEk21FFB1FdIHpjSQf+LP/W2OV/HfhC3uTPgKbRtXo83TZYEudooyZ/A
# Vu08sibZ3MkGOJORLERNwKm2G7oqdOv4Qj8Z0JrGgMzj46NFKAxkLSpE5oHQYP1H
# tPx1lPfD7iNSbJsP6LiUHXH1MIIHejCCBWKgAwIBAgIKYQ6Q0gAAAAAAAzANBgkq
# hkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5
# IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEwOTA5WjB+MQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQg
# Q29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
# CgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+laUKq4BjgaBEm6f8MMHt03
# a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc6Whe0t+bU7IKLMOv2akr
# rnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4Ddato88tt8zpcoRb0Rrrg
# OGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+lD3v++MrWhAfTVYoonpy
# 4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nkkDstrjNYxbc+/jLTswM9
# sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6A4aN91/w0FK/jJSHvMAh
# dCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmdX4jiJV3TIUs+UsS1Vz8k
# A/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL5zmhD+kjSbwYuER8ReTB
# w3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zdsGbiwZeBe+3W7UvnSSmn
# Eyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3T8HhhUSJxAlMxdSlQy90
# lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS4NaIjAsCAwEAAaOCAe0w
# ggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRIbmTlUAXTgqoXNzcitW2o
# ynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYD
# VR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBDuRQFTuHqp8cx0SOJNDBa
# BgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2Ny
# bC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3JsMF4GCCsG
# AQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3dy5taWNyb3NvZnQuY29t
# L3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3J0MIGfBgNV
# HSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEFBQcCARYzaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1hcnljcHMuaHRtMEAGCCsG
# AQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkAYwB5AF8AcwB0AGEAdABl
# AG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn8oalmOBUeRou09h0ZyKb
# C5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7v0epo/Np22O/IjWll11l
# hJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0bpdS1HXeUOeLpZMlEPXh6
# I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/KmtYSWMfCWluWpiW5IP0
# wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvyCInWH8MyGOLwxS3OW560
# STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBpmLJZiWhub6e3dMNABQam
# ASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJihsMdYzaXht/a8/jyFqGa
# J+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYbBL7fQccOKO7eZS/sl/ah
# XJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbSoqKfenoi+kiVH6v7RyOA
# 9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sLgOppO6/8MO0ETI7f33Vt
# Y5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtXcVZOSEXAQsmbdlsKgEhr
# /Xmfwb1tbWrJUnMTDXpQzTGCGaIwghmeAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAANOtTx6wYRv6ysAAAAAA04wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIPVXGc3KF16KFIKBp/SsSC38
# /ESN6/0RU5MjFOsURzDYMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAkEpPjJ47Y4HNhICzR3p7NzAW7e+USvyALt7uJnYumAGqPUtFlan4qKxV
# tzsie5TDkrHNCK0ru8xYbExggqqnysulJ29wkePN/nF35055XMivMkr/Y3F6a5eq
# i92WfxXpW9WgFEqNnpSR8RwRui5gwMXmgBtkhe9kxM7A0OsXx02P/OsHqN18E6K2
# fzmmI4alH+9/dLP8k1UF1grUIMMdvn8ihg6jJlCYVxu7aHRXGxTMq0Ox2NyPT4ll
# O/LHj1h6V8f2vZHEvxJ4Oj53FcKSabdlErf0ndUKHgT+utywAvdnhWozNxJLmRog
# VXAgkKui/yAfuVlPJXQuEb7T1i7gjKGCFywwghcoBgorBgEEAYI3AwMBMYIXGDCC
# FxQGCSqGSIb3DQEHAqCCFwUwghcBAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFZBgsq
# hkiG9w0BCRABBKCCAUgEggFEMIIBQAIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCC1LLjdrkEZYsd3sU+bCeF0Pf/uzYs+N2UklXdQBDwOagIGZVbnJ2O+
# GBMyMDIzMTEyNzA2MzEyNi45MjRaMASAAgH0oIHYpIHVMIHSMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQLEyRNaWNyb3NvZnQgSXJl
# bGFuZCBPcGVyYXRpb25zIExpbWl0ZWQxJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNO
# OkZDNDEtNEJENC1EMjIwMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNloIIRezCCBycwggUPoAMCAQICEzMAAAHimZmV8dzjIOsAAQAAAeIwDQYJ
# KoZIhvcNAQELBQAwfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwHhcNMjMx
# MDEyMTkwNzI1WhcNMjUwMTEwMTkwNzI1WjCB0jELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxhbmQgT3Bl
# cmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjpGQzQxLTRC
# RDQtRDIyMDElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZTCC
# AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALVjtZhV+kFmb8cKQpg2mzis
# DlRI978Gb2amGvbAmCd04JVGeTe/QGzM8KbQrMDol7DC7jS03JkcrPsWi9WpVwsI
# ckRQ8AkX1idBG9HhyCspAavfuvz55khl7brPQx7H99UJbsE3wMmpmJasPWpgF05z
# ZlvpWQDULDcIYyl5lXI4HVZ5N6MSxWO8zwWr4r9xkMmUXs7ICxDJr5a39SSePAJR
# IyznaIc0WzZ6MFcTRzLLNyPBE4KrVv1LFd96FNxAzwnetSePg88EmRezr2T3HTFE
# lneJXyQYd6YQ7eCIc7yllWoY03CEg9ghorp9qUKcBUfFcS4XElf3GSERnlzJsK7s
# /ZGPU4daHT2jWGoYha2QCOmkgjOmBFCqQFFwFmsPrZj4eQszYxq4c4HqPnUu4hT4
# aqpvUZ3qIOXbdyU42pNL93cn0rPTTleOUsOQbgvlRdthFCBepxfb6nbsp3fcZaPB
# fTbtXVa8nLQuMCBqyfsebuqnbwj+lHQfqKpivpyd7KCWACoj78XUwYqy1HyYnStT
# me4T9vK6u2O/KThfROeJHiSg44ymFj+34IcFEhPogaKvNNsTVm4QbqphCyknrwBy
# qorBCLH6bllRtJMJwmu7GRdTQsIx2HMKqphEtpSm1z3ufASdPrgPhsQIRFkHZGui
# hL1Jjj4Lu3CbAmha0lOrAgMBAAGjggFJMIIBRTAdBgNVHQ4EFgQURIQOEdq+7Qds
# lptJiCRNpXgJ2gUwHwYDVR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXwYD
# VR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9j
# cmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3JsMGwG
# CCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIw
# MjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcD
# CDAOBgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQELBQADggIBAORURDGrVRTbnulf
# sg2cTsyyh7YXvhVU7NZMkITAQYsFEPVgvSviCylr5ap3ka76Yz0t/6lxuczI6w7t
# Xq8n4WxUUgcj5wAhnNorhnD8ljYqbck37fggYK3+wEwLhP1PGC5tvXK0xYomU1nU
# +lXOy9ZRnShI/HZdFrw2srgtsbWow9OMuADS5lg7okrXa2daCOGnxuaD1IO+65E7
# qv2O0W0sGj7AWdOjNdpexPrspL2KEcOMeJVmkk/O0ganhFzzHAnWjtNWneU11WQ6
# Bxv8OpN1fY9wzQoiycgvOOJM93od55EGeXxfF8bofLVlUE3zIikoSed+8s61NDP+
# x9RMya2mwK/Ys1xdvDlZTHndIKssfmu3vu/a+BFf2uIoycVTvBQpv/drRJD68eo4
# 01mkCRFkmy/+BmQlRrx2rapqAu5k0Nev+iUdBUKmX/iOaKZ75vuQg7hCiBA5xIm5
# ZIXDSlX47wwFar3/BgTwntMq9ra6QRAeS/o/uYWkmvqvE8Aq38QmKgTiBnWSS/uV
# PcaHEyArnyFh5G+qeCGmL44MfEnFEhxc3saPmXhe6MhSgCIGJUZDA7336nQD8fn4
# y6534Lel+LuT5F5bFt0mLwd+H5GxGzObZmm/c3pEWtHv1ug7dS/Dfrcd1sn2E4gk
# 4W1L1jdRBbK9xwkMmwY+CHZeMSvBMIIHcTCCBVmgAwIBAgITMwAAABXF52ueAptJ
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
# tB1VM1izoXBm8qGCAtcwggJAAgEBMIIBAKGB2KSB1TCB0jELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxh
# bmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjpG
# QzQxLTRCRDQtRDIyMDElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vy
# dmljZaIjCgEBMAcGBSsOAwIaAxUAFpuZafp0bnpJdIhfiB1d8pTohm+ggYMwgYCk
# fjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDANBgkqhkiG9w0BAQUFAAIF
# AOkOk1cwIhgPMjAyMzExMjcxMjAyMzFaGA8yMDIzMTEyODEyMDIzMVowdzA9Bgor
# BgEEAYRZCgQBMS8wLTAKAgUA6Q6TVwIBADAKAgEAAgIG8wIB/zAHAgEAAgIRczAK
# AgUA6Q/k1wIBADA2BgorBgEEAYRZCgQCMSgwJjAMBgorBgEEAYRZCgMCoAowCAIB
# AAIDB6EgoQowCAIBAAIDAYagMA0GCSqGSIb3DQEBBQUAA4GBAFNzTwaJEqYhKzBU
# mP+HfN/K35kVfy7KnE6jichSSMCPnBhP7EMwGuTT6dp1tsn481KfgUb1f96CHSQu
# +czuGamlEjLk+7LY/2Zegj/0i2VmCf7pQ6CSgPe7DA0+XrGRjyZXBHklHivaQiCM
# Z2wUL9SOA8lvDhAWsikBoJkk/4/FMYIEDTCCBAkCAQEwgZMwfDELMAkGA1UEBhMC
# VVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNV
# BAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRp
# bWUtU3RhbXAgUENBIDIwMTACEzMAAAHimZmV8dzjIOsAAQAAAeIwDQYJYIZIAWUD
# BAIBBQCgggFKMBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0B
# CQQxIgQgXWF8MJT7jOYQP6/+ZE/8W5/7DICF1k797hyEu99sLTowgfoGCyqGSIb3
# DQEJEAIvMYHqMIHnMIHkMIG9BCAriSpKEP0muMbBUETODoL4d5LU6I/bjucIZkOJ
# CI9//zCBmDCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9u
# MRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRp
# b24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAAB
# 4pmZlfHc4yDrAAEAAAHiMCIEIHJUuix//iCkvziHz048lhVvbt8JQqTvqi+yR8Cv
# LmuvMA0GCSqGSIb3DQEBCwUABIICAGgS0q6sIx+TJvEkehI29QYwQj6bolSLDD4r
# 4g8q/AVbBrAlJUrvrVBvWT30WAI6HvP2iT4Wk7CLXfOxmqHNWhy7XqQbzkMT60qG
# DOKZKDjkmZ9A+UIdwfoUtOEyTbTvYImFF+7UcQE0BKy0Dt+JXo7R3Ihk5SQXsIZh
# nVNQH6hfM255XOR/RYZ+kimDi2T7VUZC2mXWWnhzZAcBkSBeEaZwb1Oj0w/LTl8o
# 02OutYKLc7bqPv3bE5/hk8uyZIXJeNxzOZ42WjNgexOPHGSQqocHfMS9jzDfREYi
# Nfm3G10o0dBNfrH3zFf+EHyg9m6b7iV4keSGzrmhDJt2oURHMZ8ZAumQDJYnohiF
# J3vB+KFTe3d51B2bnany1apJ8Biq6bMDccfJQuhZ6BnPSaBdPwHkXwNEpJS/9eVL
# 98nq/68qiIzGQjx5KFewDBzifefpixPvwRUZeM6M5g9bMjTupNYSfVzQl7z1hC6s
# w9cLA6aoWxgqa1BzK4ZIDqRO5rMa1bN+WiJRSuk9kPVgyc2veCZV8ei4Az78JHfy
# lwI3RLwwnfnvcXlxy6MZmfFHJsVrJHQoUnSXdgANA5ocSTISDPCn8L2Tv4gZDIrn
# 4brS3ICCQOnvMTzVHQQYNo8F1QkG3kiMLf5x/8ngzSMRNq3os/AJceQhISkyknRz
# GxVSzdVZ
# SIG # End signature block