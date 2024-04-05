
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
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
Lists entities from service principals or get entity from service principals by key
.Description
Lists entities from service principals or get entity from service principals by key
.Link
https://learn.microsoft.com/powershell/module/az.resources/get-azadserviceprincipal
#>
function Get-AzADServicePrincipal {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphServicePrincipal])]
[CmdletBinding(DefaultParameterSetName='EmptyParameterSet', PositionalBinding=$false)]
param(
    [Parameter(ParameterSetName='ObjectIdParameterSet', Mandatory)]
    [Alias('ServicePrincipalId', 'Id')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Path')]
    [System.String]
    # key: id of servicePrincipal
    ${ObjectId},

    [Parameter(ParameterSetName='SearchStringParameterSet', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Query')]
    [Alias('DisplayNameStartsWith', "SearchString")]
    [System.String]
    # serviceprincipal display name starts with
    ${DisplayNameBeginsWith},

    [Parameter(ParameterSetName='DisplayNameParameterSet', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Query')]
    [System.String]
    # serviceprincipal display name
    ${DisplayName},

    [Parameter(ParameterSetName='ApplicationIdParameterSet', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Query')]
    [Alias('AppId')]
    [System.Guid]
    # application id of serviceprincipal
    ${ApplicationId},

    [Parameter(ParameterSetName='ApplicationObjectParameterSet', Mandatory, ValueFromPipeline, HelpMessage = "The service principal object, could be used as pipeline input.")]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Query')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphApplication]
    # application object
    ${ApplicationObject},

    [Parameter(ParameterSetName='SPNParameterSet', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Query')]
    [System.String]
    [Alias("SPN")]
    # serviceprincipal name
    ${ServicePrincipalName},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Query')]
    [System.String[]]
    # Select properties to be returned
    ${Select},

    [Parameter(ParameterSetName='EmptyParameterSet')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Query')]
    [System.Management.Automation.SwitchParameter]
    # Include count of items
    ${Count},

    [Parameter(ParameterSetName='EmptyParameterSet')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Query')]
    [System.String]
    # Filter items by property values, for more detail about filter query please see: https://learn.microsoft.com/en-us/graph/filter-query-parameter
    ${Filter},

    [Parameter(ParameterSetName='EmptyParameterSet')]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Query')]
    [System.String[]]
    # Order items by property values
    ${Orderby},

    [Parameter(ParameterSetName='EmptyParameterSet')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Query')]
    [System.String]
    # Search items by search phrases
    ${Search},

    [Parameter(ParameterSetName='EmptyParameterSet')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Header')]
    [System.String]
    # Indicates the requested consistency level.
    # Documentation URL: https://developer.microsoft.com/en-us/office/blogs/microsoft-graph-advanced-queries-for-directory-objects-are-now-generally-available/
    ${ConsistencyLevel},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.UInt64]
    # Gets only the first 'n' objects.
    ${First},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.UInt64]
    # Ignores the first 'n' objects and then gets the remaining objects.
    ${Skip},

    [Parameter(HelpMessage = "Append properties selected with default properties when this switch is on, only works with parameter '-Select'.")]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.Management.Automation.SwitchParameter]
    ${AppendSelected},

    [Parameter(ParameterSetName='EmptyParameterSet')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.String]
    # Specifies a count of the total number of items in a collection.
    # By default, this variable will be set in the global scope.
    ${CountVariable},

    [Parameter()]
    [Alias("AzContext", "AzureRmContext", "AzureCredential")]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

process {
    if ($PSBoundParameters['AppendSelected'] -and $PSBoundParameters['Select']) {
        $PSBoundParameters['Select'] += @('DisplayName', 'Id', 'DeletedDateTime', 'ServicePrincipalNames', 'AppId')
        $null = $PSBoundParameters.Remove('AppendSelected')
    }

    switch ($PSCmdlet.ParameterSetName) {
        "ObjectIdParameterSet" {
            $PSBoundParameters['Id'] = $PSBoundParameters['ObjectId']
            $null = $PSBoundParameters.Remove('ObjectId')
            break
        }
        'SearchStringParameterSet' {
            $PSBoundParameters['Filter'] = "startsWith(DisplayName, '$($PSBOundParameters['DisplayNameBeginsWith'])')"
            $null = $PSBoundParameters.Remove('DisplayNameBeginsWith')
            break
        }
        'DisplayNameParameterSet' {
            $PSBOundParameters['Filter'] = "displayName eq '$($PSBOundParameters['DisplayName'])'"
            $null = $PSBoundParameters.Remove('DisplayName')
            break
        }
        'ApplicationObjectParameterSet' {
            $PSBoundParameters['Filter'] = "AppId eq '$($PSBoundParameters['ApplicationObject'].AppId)'"
            $null = $PSBoundParameters.Remove('ApplicationObject')
            break
        }
        'ApplicationIdParameterSet' {
            $PSBoundParameters['Filter'] = "AppId eq '$($PSBoundParameters['ApplicationId'])'"
            $null = $PSBoundParameters.Remove('ApplicationId')
            break
        }
        'SPNParameterSet' {
            $PSBoundParameters['Filter'] = "ServicePrincipalNames/any(s:s eq '$($PSBoundParameters['ServicePrincipalName'])')"
            $null = $PSBoundParameters.Remove('ServicePrincipalName')
            break
        }
        default {
            break
        }
    }

    Az.MSGraph.internal\Get-AzADServicePrincipal @PSBoundParameters
}
}

# SIG # Begin signature block
# MIIoKgYJKoZIhvcNAQcCoIIoGzCCKBcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDLDRRUAv/bkkDt
# MbMtG2f7SVW656KFJ5nMqMcq6/edwKCCDXYwggX0MIID3KADAgECAhMzAAADTrU8
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
# /Xmfwb1tbWrJUnMTDXpQzTGCGgowghoGAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAANOtTx6wYRv6ysAAAAAA04wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEII9/pgzfrK8hGDgAsFRXAguE
# Lh3mGrtKq9n6if0g95cjMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAI+F5rQ5Sl7cXPSA+sJFa7IUVolHyV3xc3U4+Wb1TJvZWcWn+wN/v6zDr
# YcUP73PngoyO85if8shNJ/LDLzjPjY3WevDlKypkNX1oAEOSLW2PtY+oeO/dQn/1
# uHgVUiRdWo3lElWGTrVhB151Sjkcm+EpLsUPi8Jhlg6af42NrrN4nZkdZf601y2Q
# XWYqb+ClPc5F4bxfNgB6KReMf/XdC3H/FZQpOg6K5M6Y/OKKi5vztjgUqqjCHmcs
# hM+Qu6p/z67iDWhwNJfCyK7CPGiG3S/n5iBc/fPBFmuZJURAegLGwC7rWaXIAXHX
# rAOEI1zzq0MNO/VyWYRbcs3vXdOR2qGCF5QwgheQBgorBgEEAYI3AwMBMYIXgDCC
# F3wGCSqGSIb3DQEHAqCCF20wghdpAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFSBgsq
# hkiG9w0BCRABBKCCAUEEggE9MIIBOQIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCDSbsI8Ks7h+oNavckCx7RFtSD4m+ZH9UbM24fwScDXWgIGZVbGnwZ+
# GBMyMDIzMTEyNzA2MzEwNi43MzVaMASAAgH0oIHRpIHOMIHLMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1l
# cmljYSBPcGVyYXRpb25zMScwJQYDVQQLEx5uU2hpZWxkIFRTUyBFU046OTIwMC0w
# NUUwLUQ5NDcxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2Wg
# ghHqMIIHIDCCBQigAwIBAgITMwAAAc9SNr5xS81IygABAAABzzANBgkqhkiG9w0B
# AQsFADB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYD
# VQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDAeFw0yMzA1MjUxOTEy
# MTFaFw0yNDAyMDExOTEyMTFaMIHLMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
# aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
# cnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1lcmljYSBPcGVyYXRpb25z
# MScwJQYDVQQLEx5uU2hpZWxkIFRTUyBFU046OTIwMC0wNUUwLUQ5NDcxJTAjBgNV
# BAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2UwggIiMA0GCSqGSIb3DQEB
# AQUAA4ICDwAwggIKAoICAQC4Pct+15TYyrUje553lzBQodgmd5Bz7WuH8SdHpAoW
# z+01TrHExBSuaMKnxvVMsyYtas5h6aopUGAS5WKVLZAvUtH62TKmAE0JK+i1hafi
# CSXLZPcRexxeRkOqeZefLBzXp0nudMOXUUab333Ss8LkoK4l3LYxm1Ebsr3b2OTo
# 2ebsAoNJ4kSxmVuPM7C+RDhGtVKR/EmHsQ9GcwGmluu54bqiVFd0oAFBbw4txTU1
# mruIGWP/i+sgiNqvdV/wah/QcrKiGlpWiOr9a5aGrJaPSQD2xgEDdPbrSflYxsRM
# dZCJI8vzvOv6BluPcPPGGVLEaU7OszdYjK5f4Z5Su/lPK1eST5PC4RFsVcOiS4L0
# sI4IFZywIdDJHoKgdqWRp6Q5vEDk8kvZz6HWFnYLOlHuqMEYvQLr6OgooYU9z0A5
# cMLHEIHYV1xiaBzx2ERiRY9MUPWohh+TpZWEUZlUm/q9anXVRN0ujejm6OsUVFDs
# sIMszRNCqEotJGwtHHm5xrCKuJkFr8GfwNelFl+XDoHXrQYL9zY7Np+frsTXQpKR
# NnmI1ashcn5EC+wxUt/EZIskWzewEft0/+/0g3+8YtMkUdaQE5+8e7C8UMiXOHkM
# K25jNNQqLCedlJwFIf9ir9SpMc72NR+1j6Uebiz/ZPV74do3jdVvq7DiPFlTb92U
# KwIDAQABo4IBSTCCAUUwHQYDVR0OBBYEFDaeKPtp0eTSVdG+gZc5BDkabTg4MB8G
# A1UdIwQYMBaAFJ+nFV0AXmJdg/Tl0mWnG1M1GelyMF8GA1UdHwRYMFYwVKBSoFCG
# Tmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY3Jvc29mdCUy
# MFRpbWUtU3RhbXAlMjBQQ0ElMjAyMDEwKDEpLmNybDBsBggrBgEFBQcBAQRgMF4w
# XAYIKwYBBQUHMAKGUGh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY2Vy
# dHMvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3J0MAwG
# A1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwDgYDVR0PAQH/BAQD
# AgeAMA0GCSqGSIb3DQEBCwUAA4ICAQBQgm4pnA0xkd/9uKXJMzdMYyxUfUm/ZusU
# Ba32MEZXQuMGp20pSuX2VW9/tpTMo5bkaJdBVoUyd2DbDsNb1kjr/36ntT0jvL3A
# oWStAFhZBypmpPbx+BPK49ZlejlM4d5epX668tRRGfFip9Til9yKRfXBrXnM/q64
# IinN7zXEQ3FFQhdJMzt8ibXClO7eFA+1HiwZPWysYWPb/ZOFobPEMvXie+GmEbTK
# bhE5tze6RrA9aejjP+v1ouFoD5bMj5Qg+wfZXqe+hfYKpMd8QOnQyez+Nlj1ityn
# OZWfwHVR7dVwV0yLSlPT+yHIO8g+3fWiAwpoO17bDcntSZ7YOBljXrIgad4W4gX+
# 4tp1eBsc6XWIITPBNzxQDZZRxD4rXzOB6XRlEVJdYZQ8gbXOirg/dNvS2GxcR50Q
# dOXDAumdEHaGNHb6y2InJadCPp2iT5QLC4MnzR+YZno1b8mWpCdOdRs9g21QbbrI
# 06iLk9KD61nx7K5ReSucuS5Z9nbkIBaLUxDesFhr1wmd1ynf0HQ51Swryh7YI7TX
# T0jr81mbvvI9xtoqjFvIhNBsICdCfTR91ylJTH8WtUlpDhEgSqWt3gzNLPTSvXAx
# XTpIM583sZdd+/2YGADMeWmt8PuMce6GsIcLCOF2NiYZ10SXHZS5HRrLrChuzedD
# RisWpIu5uTCCB3EwggVZoAMCAQICEzMAAAAVxedrngKbSZkAAAAAABUwDQYJKoZI
# hvcNAQELBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAw
# DgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24x
# MjAwBgNVBAMTKU1pY3Jvc29mdCBSb290IENlcnRpZmljYXRlIEF1dGhvcml0eSAy
# MDEwMB4XDTIxMDkzMDE4MjIyNVoXDTMwMDkzMDE4MzIyNVowfDELMAkGA1UEBhMC
# VVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNV
# BAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRp
# bWUtU3RhbXAgUENBIDIwMTAwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoIC
# AQDk4aZM57RyIQt5osvXJHm9DtWC0/3unAcH0qlsTnXIyjVX9gF/bErg4r25Phdg
# M/9cT8dm95VTcVrifkpa/rg2Z4VGIwy1jRPPdzLAEBjoYH1qUoNEt6aORmsHFPPF
# dvWGUNzBRMhxXFExN6AKOG6N7dcP2CZTfDlhAnrEqv1yaa8dq6z2Nr41JmTamDu6
# GnszrYBbfowQHJ1S/rboYiXcag/PXfT+jlPP1uyFVk3v3byNpOORj7I5LFGc6XBp
# Dco2LXCOMcg1KL3jtIckw+DJj361VI/c+gVVmG1oO5pGve2krnopN6zL64NF50Zu
# yjLVwIYwXE8s4mKyzbnijYjklqwBSru+cakXW2dg3viSkR4dPf0gz3N9QZpGdc3E
# XzTdEonW/aUgfX782Z5F37ZyL9t9X4C626p+Nuw2TPYrbqgSUei/BQOj0XOmTTd0
# lBw0gg/wEPK3Rxjtp+iZfD9M269ewvPV2HM9Q07BMzlMjgK8QmguEOqEUUbi0b1q
# GFphAXPKZ6Je1yh2AuIzGHLXpyDwwvoSCtdjbwzJNmSLW6CmgyFdXzB0kZSU2LlQ
# +QuJYfM2BjUYhEfb3BvR/bLUHMVr9lxSUV0S2yW6r1AFemzFER1y7435UsSFF5PA
# PBXbGjfHCBUYP3irRbb1Hode2o+eFnJpxq57t7c+auIurQIDAQABo4IB3TCCAdkw
# EgYJKwYBBAGCNxUBBAUCAwEAATAjBgkrBgEEAYI3FQIEFgQUKqdS/mTEmr6CkTxG
# NSnPEP8vBO4wHQYDVR0OBBYEFJ+nFV0AXmJdg/Tl0mWnG1M1GelyMFwGA1UdIARV
# MFMwUQYMKwYBBAGCN0yDfQEBMEEwPwYIKwYBBQUHAgEWM2h0dHA6Ly93d3cubWlj
# cm9zb2Z0LmNvbS9wa2lvcHMvRG9jcy9SZXBvc2l0b3J5Lmh0bTATBgNVHSUEDDAK
# BggrBgEFBQcDCDAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMC
# AYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBTV9lbLj+iiXGJo0T2UkFvX
# zpoYxDBWBgNVHR8ETzBNMEugSaBHhkVodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20v
# cGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXRfMjAxMC0wNi0yMy5jcmwwWgYI
# KwYBBQUHAQEETjBMMEoGCCsGAQUFBzAChj5odHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpL2NlcnRzL01pY1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNydDANBgkqhkiG
# 9w0BAQsFAAOCAgEAnVV9/Cqt4SwfZwExJFvhnnJL/Klv6lwUtj5OR2R4sQaTlz0x
# M7U518JxNj/aZGx80HU5bbsPMeTCj/ts0aGUGCLu6WZnOlNN3Zi6th542DYunKmC
# VgADsAW+iehp4LoJ7nvfam++Kctu2D9IdQHZGN5tggz1bSNU5HhTdSRXud2f8449
# xvNo32X2pFaq95W2KFUn0CS9QKC/GbYSEhFdPSfgQJY4rPf5KYnDvBewVIVCs/wM
# nosZiefwC2qBwoEZQhlSdYo2wh3DYXMuLGt7bj8sCXgU6ZGyqVvfSaN0DLzskYDS
# PeZKPmY7T7uG+jIa2Zb0j/aRAfbOxnT99kxybxCrdTDFNLB62FD+CljdQDzHVG2d
# Y3RILLFORy3BFARxv2T5JL5zbcqOCb2zAVdJVGTZc9d/HltEAY5aGZFrDZ+kKNxn
# GSgkujhLmm77IVRrakURR6nxt67I6IleT53S0Ex2tVdUCbFpAUR+fKFhbHP+Crvs
# QWY9af3LwUFJfn6Tvsv4O+S3Fb+0zj6lMVGEvL8CwYKiexcdFYmNcP7ntdAoGokL
# jzbaukz5m/8K6TT4JDVnK+ANuOaMmdbhIurwJ0I9JZTmdHRbatGePu1+oDEzfbzL
# 6Xu/OHBE0ZDxyKs6ijoIYn/ZcGNTTY3ugm2lBRDBcQZqELQdVTNYs6FwZvKhggNN
# MIICNQIBATCB+aGB0aSBzjCByzELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hp
# bmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jw
# b3JhdGlvbjElMCMGA1UECxMcTWljcm9zb2Z0IEFtZXJpY2EgT3BlcmF0aW9uczEn
# MCUGA1UECxMeblNoaWVsZCBUU1MgRVNOOjkyMDAtMDVFMC1EOTQ3MSUwIwYDVQQD
# ExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNloiMKAQEwBwYFKw4DAhoDFQDq
# 8xzVXwLguauAQj1rrJ4/TyEMm6CBgzCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFBDQSAyMDEwMA0GCSqGSIb3DQEBCwUAAgUA6Q5zyTAiGA8yMDIzMTEyNzAxNDc1
# M1oYDzIwMjMxMTI4MDE0NzUzWjB0MDoGCisGAQQBhFkKBAExLDAqMAoCBQDpDnPJ
# AgEAMAcCAQACAhM0MAcCAQACAhPgMAoCBQDpD8VJAgEAMDYGCisGAQQBhFkKBAIx
# KDAmMAwGCisGAQQBhFkKAwKgCjAIAgEAAgMHoSChCjAIAgEAAgMBhqAwDQYJKoZI
# hvcNAQELBQADggEBAJyNphk6jAUTeUFJATpdqAR1GDsqoqw/X8bIzxv5jCR2BQsC
# boV5jAMTSroLHMQlWvWgXx9AZ3hu8W3bGTA+uyJW91BwCnL//gDW/Gpf8qaRTEWg
# 4K9FfOAcdktR4JcgQiZLLamTBap3L5pm9WpFjFj4c/zMgnPx/rM1346eMjv6RquA
# +7jxkoS3+rLqca/+H+NPDfEcCjjJdorfet6Nyvp8QEtWDQvvoKRDXERKsFEve9Ze
# 8YaSrwtnzcBXw7nhdB64bw0SXp799R7K+Ymn5MlctvAL2aeRJyoC6zaNpE97mFx2
# jnjLOlwFc/xH+KliprNBfSUYdUCv0ckWheSaXfwxggQNMIIECQIBATCBkzB8MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNy
# b3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAITMwAAAc9SNr5xS81IygABAAABzzAN
# BglghkgBZQMEAgEFAKCCAUowGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8G
# CSqGSIb3DQEJBDEiBCArZjrR/C2CxMH2elEnqHmuIH9Raq9mVyuTKwp6O6EKMjCB
# +gYLKoZIhvcNAQkQAi8xgeowgecwgeQwgb0EILPpsLqeNS4NuYXE2VJlMuvQeWVA
# 80ZDFhpOPjSzhPa/MIGYMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldh
# c2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBD
# b3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIw
# MTACEzMAAAHPUja+cUvNSMoAAQAAAc8wIgQg7GqUKNQwg0m61LNEWJtSz0FEYJEg
# tG2zqwuftRc7DQ4wDQYJKoZIhvcNAQELBQAEggIAXEwlYgyTf2zBkj3lTcd+QOQa
# dXUyIirmqd1jvItzegKDYLS3SN2v7FZKCL7OB8C7It2XjY1Q/6R5+q2MfwOf2mLk
# 1CIwgH0XMMJdIXSx16irXABKudbRw0+QUaXZGhEUdf9Y0+2YHNclsrd6fMGUSK7A
# bmuTzQQW/PXNIxkqIjAYhESCRI4OfqNdEfkAfzp8yBRgbQSyF4oARFRhUex9XR6L
# FVwGMQGqwnVESZMenJgn/rhp+raqrPwUgap2mDAZs0KwR6LTHG6X+D11fy/MRij5
# KRuDyXOZTWxlvY2Jpjq8GXMIm3VFFGSUAbiAPD/tkSRI5mzxGHBBRxepWpUgQSuG
# er2v0u4I0NTfoY+5aPqQJ5lKdfAP9N2MYTSztV4s2n1NbI2fxEqj/BhkjSunPk0F
# kdZtIEHA2jC8OIXOZp4K07ylUzxE/C1O7u5zJ9amYDedwrXRqkiSSa5R0BcCcVMx
# glbpDgoUst77bz1OfQFgiyr0dImpFahuoIp/3sSwtZm57cBYyrM7RkJHUJ5oJgE9
# OREqOR7DbsisxLGiUiBF1hUwx5nIcaJq35s8HnFQNOLev6Bwr+2rW2kDxH6u4QFM
# PfQWHDjgpJslka+imdAQCNkYdPqzWxr0cFYPbDkeTMlkQX1la3cElcOJdIOxkSVY
# KdWW6yx/XTBK55Cjcpk=
# SIG # End signature block
