# ----------------------------------------------------------------------------------
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# https://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Adds an API permission.
.Description
Adds an API permission. The list of available permissions of API is property of application represented by service principal in tenant.

For instance, to get available permissions for Graph API:
* Azure Active Directory Graph: `Get-AzAdServicePrincipal -ApplicationId 00000002-0000-0000-c000-000000000000`
* Microsoft Graph: `Get-AzAdServicePrincipal -ApplicationId 00000003-0000-0000-c000-000000000000`

Application permissions under the `appRoles` property correspond to `Role` in `-Type`. Delegated permissions under the `oauth2Permissions` property correspond to `Scope` in `-Type`.

User needs to grant consent via Azure Portal if the permission requires admin consent because Azure PowerShell doesn't support it yet.
.Link
https://learn.microsoft.com/powershell/module/az.resources/add-azadapppermission
#>

function Add-AzADAppPermission {
    [OutputType([System.Boolean])]
    [CmdletBinding(DefaultParameterSetName='ObjectIdParameterSet', SupportsShouldProcess, PositionalBinding=$false)]
    param(
        [Parameter(ParameterSetName='ObjectIdParameterSet', Mandatory, HelpMessage = "The unique identifier in Azure AD.")]
        [System.Guid]
        ${ObjectId},

        [Parameter(ParameterSetName='AppIdParameterSet', Mandatory, HelpMessage = "The application Id.")]
        [System.Guid]
        ${ApplicationId},

        [Parameter(Mandatory, HelpMessage = "The unique identifier for the resource that the application requires access to.  This should be equal to the appId declared on the target resource application.")]
        [ValidateNotNull()]
        [System.Guid]
        ${ApiId},

        [Parameter(Mandatory, HelpMessage = "The unique identifier for one of the oauth2PermissionScopes or appRole instances that the resource application exposes.")]
        [ValidateNotNull()]
        [System.String]
        ${PermissionId},

        [Parameter(HelpMessage = "Specifies whether the id property references an oauth2PermissionScopes(Scope, delegated permission) or an appRole(Role, application permission).")]
        [ValidateSet('Scope', 'Role')]
        [System.String]
        ${Type} = 'Scope',

        [Parameter()]
        [Alias("AzContext", "AzureRmContext", "AzureCredential")]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Azure')]
        [System.Management.Automation.PSObject]
        # The credentials, account, tenant, and subscription used for communication with Azure.
        ${DefaultProfile},

        [Parameter(DontShow)]
        [System.Management.Automation.SwitchParameter]
        # Wait for .NET debugger to attach
        ${Break},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be appended to the front of the pipeline
        ${HttpPipelineAppend},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be prepended to the front of the pipeline
        ${HttpPipelinePrepend},

        [Parameter(DontShow)]
        [System.Uri]
        # The URI for the proxy server to use
        ${Proxy},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        # Credentials for a proxy server to use for the remote call
        ${ProxyCredential},

        [Parameter(DontShow)]
        [System.Management.Automation.SwitchParameter]
        # Use the default credentials for the proxy
        ${ProxyUseDefaultCredentials}
    )

    process {
        switch ($PSCmdlet.ParameterSetName) {
            'ObjectIdParameterSet' {
                $app = Az.MSGraph.internal\Get-AzADApplication -Id $PSBoundParameters['ObjectId']
                if($null -eq $app) {
                    Write-Error "Cannot find application by ObjectId $($PSBoundParameters['ObjectId'])"
                }
                break
            }
            'AppIdParameterSet' {
                $app = Get-AzADApplication -ApplicationId $PSBoundParameters['ApplicationId']
                if($null -eq $app) {
                    Write-Error "Cannot find application by ApplicationId $($PSBoundParameters['ApplicationId'])"
                }
                break
            }
            default {
                break
            }
        }

        $newRequiredResourceAccess = @()
        $foundRequiredResourceAccessItem = $null
        $newRequiredResourceAccessItem = $null
        foreach ($item in $app.RequiredResourceAccess) {
            if($item.resourceAppId -eq $ApiId) {
                $foundRequiredResourceAccessItem = $item
            } else {
                $newRequiredResourceAccess += $item
            }
        }

        $newRequiredResourceAccessItem = New-Object Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphRequiredResourceAccess
        $newRequiredResourceAccessItem.resourceAppId = $ApiId
        $newRequiredResourceAccessItem.resourceAccess = @()

        foreach ($item in $foundRequiredResourceAccessItem.ResourceAccess) {
            if($item.Id -eq $PermissionId -and $item.Type -eq $Type) {
                Write-Error "API permission with id '$($PSBoundParameters['PermissionId'])' already exists."
                return
            }
            $newRequiredResourceAccessItem.resourceAccess += $item
        }

        $newResourceAccess = New-Object Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphResourceAccess
        $newResourceAccess.Id = $PermissionId
        $newResourceAccess.Type = $Type
        
        $newRequiredResourceAccessItem.resourceAccess += $newResourceAccess
        $newRequiredResourceAccess += $newRequiredResourceAccessItem
        $null = Update-AzADApplication -InputObject $app -RequiredResourceAccess $newRequiredResourceAccess
    }
}

# SIG # Begin signature block
# MIIoKgYJKoZIhvcNAQcCoIIoGzCCKBcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDMJvuAbMhyxDfP
# Zq0y/CLm6PZ2LLPFT94Q7UeqLUPReqCCDXYwggX0MIID3KADAgECAhMzAAADTrU8
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
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEILubmQKbM1JzI9299GWNXJ28
# VZo/ipKaHWEGCgFIuNaRMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAxL0yTekeRaAgy3Xa2V4ptQCjbdM/xsQYt6NldCtKgv2SpftV0JLMUwz8
# Tl3TUaVpuC4OW6xfjle0vvhwf2Wh949SNnPAYixEsoo5c4SRhxfWeqkbzYuy5XVU
# Bsdqy/RbpJkvp313tr0U/4reJR80fD8qO7zx7vwCZg+jVIxacY+uQAr/fO+zy8a8
# pUABjIllkSELBp0zha4MVhh5O9tJXOLQ4MgaHAFYn8MstcGyss9B+fFHYqauCZSr
# xfTwkITwDfHRW3P/PXdWgOMUeDsC0G+1cvlu/6sFrTtay5PhrBWVxyCqrFTRl5ti
# 9leeDpz7CXKzULRapRuURm80E/DqzqGCF5QwgheQBgorBgEEAYI3AwMBMYIXgDCC
# F3wGCSqGSIb3DQEHAqCCF20wghdpAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFSBgsq
# hkiG9w0BCRABBKCCAUEEggE9MIIBOQIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCBgVLzt3TO3TU2G0cGpV8AZh9x6kdrdIUaOOUeH5S4wUAIGZVbHn5RT
# GBMyMDIzMTEyNzA2MzEwNy43MDZaMASAAgH0oIHRpIHOMIHLMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1l
# cmljYSBPcGVyYXRpb25zMScwJQYDVQQLEx5uU2hpZWxkIFRTUyBFU046REMwMC0w
# NUUwLUQ5NDcxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2Wg
# ghHqMIIHIDCCBQigAwIBAgITMwAAAdIhJDFKWL8tEQABAAAB0jANBgkqhkiG9w0B
# AQsFADB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYD
# VQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDAeFw0yMzA1MjUxOTEy
# MjFaFw0yNDAyMDExOTEyMjFaMIHLMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
# aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
# cnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1lcmljYSBPcGVyYXRpb25z
# MScwJQYDVQQLEx5uU2hpZWxkIFRTUyBFU046REMwMC0wNUUwLUQ5NDcxJTAjBgNV
# BAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2UwggIiMA0GCSqGSIb3DQEB
# AQUAA4ICDwAwggIKAoICAQDcYIhC0QI/SPaT5+nYSBsSdhBPO2SXM40Vyyg8Fq1T
# PrMNDzxChxWUD7fbKwYGSsONgtjjVed5HSh5il75jNacb6TrZwuX+Q2++f2/8CCy
# u8TY0rxEInD3Tj52bWz5QRWVQejfdCA/n6ZzinhcZZ7+VelWgTfYC7rDrhX3TBX8
# 9elqXmISOVIWeXiRK8h9hH6SXgjhQGGQbf2bSM7uGkKzJ/pZ2LvlTzq+mOW9iP2j
# cYEA4bpPeurpglLVUSnGGQLmjQp7Sdy1wE52WjPKdLnBF6JbmSREM/Dj9Z7okxRN
# UjYSdgyvZ1LWSilhV/wegYXVQ6P9MKjRnE8CI5KMHmq7EsHhIBK0B99dFQydL1vd
# uC7eWEjzz55Z/DyH6Hl2SPOf5KZ4lHf6MUwtgaf+MeZxkW0ixh/vL1mX8VsJTHa8
# AH+0l/9dnWzFMFFJFG7g95nHJ6MmYPrfmoeKORoyEQRsSus2qCrpMjg/P3Z9WJAt
# FGoXYMD19NrzG4UFPpVbl3N1XvG4/uldo1+anBpDYhxQU7k1gfHn6QxdUU0TsrJ/
# JCvLffS89b4VXlIaxnVF6QZh+J7xLUNGtEmj6dwPzoCfL7zqDZJvmsvYNk1lcbyV
# xMIgDFPoA2fZPXHF7dxahM2ZG7AAt3vZEiMtC6E/ciLRcIwzlJrBiHEenIPvxW15
# qwIDAQABo4IBSTCCAUUwHQYDVR0OBBYEFCC2n7cnR3ToP/kbEZ2XJFFmZ1kkMB8G
# A1UdIwQYMBaAFJ+nFV0AXmJdg/Tl0mWnG1M1GelyMF8GA1UdHwRYMFYwVKBSoFCG
# Tmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY3Jvc29mdCUy
# MFRpbWUtU3RhbXAlMjBQQ0ElMjAyMDEwKDEpLmNybDBsBggrBgEFBQcBAQRgMF4w
# XAYIKwYBBQUHMAKGUGh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY2Vy
# dHMvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3J0MAwG
# A1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwDgYDVR0PAQH/BAQD
# AgeAMA0GCSqGSIb3DQEBCwUAA4ICAQCw5iq0Ey0LlAdz2PcqchRwW5d+fitNISCv
# qD0E6W/AyiTk+TM3WhYTaxQ2pP6Or4qOV+Du7/L+k18gYr1phshxVMVnXNcdjecM
# tTWUOVAwbJoeWHaAgknNIMzXK3+zguG5TVcLEh/CVMy1J7KPE8Q0Cz56NgWzd9ur
# G+shSDKkKdhOYPXF970Mr1GCFFpe1oXjEy6aS+Heavp2wmy65mbu0AcUOPEn+hYq
# ijgLXSPqvuFmOOo5UnSV66Dv5FdkqK7q5DReox9RPEZcHUa+2BUKPjp+dQ3D4c9I
# H8727KjMD8OXZomD9A8Mr/fcDn5FI7lfZc8ghYc7spYKTO/0Z9YRRamhVWxxrIsB
# N5LrWh+18soXJ++EeSjzSYdgGWYPg16hL/7Aydx4Kz/WBTUmbGiiVUcE/I0aQU2U
# /0NzUiIFIW80SvxeDWn6I+hyVg/sdFSALP5JT7wAe8zTvsrI2hMpEVLdStFAMqan
# FYqtwZU5FoAsoPZ7h1ElWmKLZkXk8ePuALztNY1yseO0TwdueIGcIwItrlBYg1Xp
# Pz1+pMhGMVble6KHunaKo5K/ldOM0mQQT4Vjg6ZbzRIVRoDcArQ5//0875jOUvJt
# Yyc7Hl04jcmvjEIXC3HjkUYvgHEWL0QF/4f7vLAchaEZ839/3GYOdqH5VVnZrUIB
# QB6DTaUILDCCB3EwggVZoAMCAQICEzMAAAAVxedrngKbSZkAAAAAABUwDQYJKoZI
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
# MCUGA1UECxMeblNoaWVsZCBUU1MgRVNOOkRDMDAtMDVFMC1EOTQ3MSUwIwYDVQQD
# ExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNloiMKAQEwBwYFKw4DAhoDFQCJ
# ptLCZsE06NtmHQzB5F1TroFSBqCBgzCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFBDQSAyMDEwMA0GCSqGSIb3DQEBCwUAAgUA6Q50zTAiGA8yMDIzMTEyNzAxNTIx
# M1oYDzIwMjMxMTI4MDE1MjEzWjB0MDoGCisGAQQBhFkKBAExLDAqMAoCBQDpDnTN
# AgEAMAcCAQACAhErMAcCAQACAhMOMAoCBQDpD8ZNAgEAMDYGCisGAQQBhFkKBAIx
# KDAmMAwGCisGAQQBhFkKAwKgCjAIAgEAAgMHoSChCjAIAgEAAgMBhqAwDQYJKoZI
# hvcNAQELBQADggEBALE6LmOKdgHfaclNDJZC4DkBk+alo0dT6kXg0sSGqQe4zfqV
# iVN8W8ipSv0ak93rp/xUTclRz6OvBbJlXupzUDxVn3nfG+Tf0QKagtjndBmPtkS2
# tiwWK2UGBteLitEIpy/Gb9r41df+ikFb2OCASv12f8UE1HT1efqAMoaHWKTuv84F
# 4piB2XIhDuOuG72yeSAtghml8xrwNp5WxbFRpSLf8MR6hn/VIKZQqfXyN+W7zBRK
# e1G6dM6MSPWPTx98rxttcphl8aLB/0TpGNew6K1/+gdr5xodzOFniuiseuGqeF3c
# HF7C/nP1zp8pFcZd18SEYHK4i74F5T7kuKdFd6QxggQNMIIECQIBATCBkzB8MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNy
# b3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAITMwAAAdIhJDFKWL8tEQABAAAB0jAN
# BglghkgBZQMEAgEFAKCCAUowGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8G
# CSqGSIb3DQEJBDEiBCCMGBsufHkIwLE8nWVXAd+e+ZD0l1GuoJ9fMxKmdMq0yjCB
# +gYLKoZIhvcNAQkQAi8xgeowgecwgeQwgb0EIMeAIJPf30i9ZbOExU557GwWNaLH
# 0Z5s65JFga2DeaROMIGYMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldh
# c2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBD
# b3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIw
# MTACEzMAAAHSISQxSli/LREAAQAAAdIwIgQgUUihQOUTcbOBKvrwWa9b9TD2Ratf
# Ha1g6Dzcdc+3m74wDQYJKoZIhvcNAQELBQAEggIAEoBlTxYF5K2uvgFb5z2T2Mun
# 6zTM74NOs51cBYz4VG8IHPWSyJAW7J2Une0ztonKgT0DdNCz9uK5+Nfies04ZEy7
# W7eBG7OuxdSVQMXcYddovxI43gW1HD5aalWAj7MH+Rn6nkIj8e21JxWx6sV/HqpD
# Ab9kMJo7S9Q0sJmSGQFvWGHmsjGPu1wzfOsLsqOj/qTNjQD+T0el/W7yZSrUlBkj
# eyHSXtvS6PPR1cnRs+Uekf0bN+wB6po0n86cAw7sWtHDzRmyIG6NpsSZu1swJRrY
# 1G+e+Uay3AFiocGYsPDLQuQtpht9fVlyNWj3q/vO6XXELCc6VTL6rbYpSnVugznU
# gBx0JviczxtHmPadISwruJBI6q1Az/GKwG9UIjFoRiKK7M+x7OU4IHNz3R6tZiQI
# aRgkgmL/7MeGFVhHjPVqOB5SPhkVjt6UxT7uI5ipp1fLS1kC0Hh4JN55l0hqo6Mx
# idMcx9XsN/6wCEMvn4yB7odVhuzqso/rhB/m5RcpfsZ42J1u9+FV3clDk3V6/Z3T
# fMct+ir8cwg8bvI+WXff6PgmyZFvD8faThIpRxmlF4UYT85/TCD189VTRdhOhJs+
# YQ+yCkB9pV2zis/FLFF5MnCXAVt+TbvmxCBqpxPZHZZJUlu/esF9/WK8p9sELdDh
# wtUUqAYtxBkGRHlBGMw=
# SIG # End signature block
