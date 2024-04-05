
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
Creates key credentials or password credentials for an application.
.Description
Creates key credentials or password credentials for an application.
.Link
https://learn.microsoft.com/powershell/module/az.resources/new-azadappcredential
#>

function New-AzADAppCredential {
    [OutputType([Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphKeyCredential], [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphPasswordCredential])]
    [CmdletBinding(DefaultParameterSetName = 'ApplicationObjectIdWithPasswordParameterSet', PositionalBinding = $false, SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'ApplicationObjectIdWithPasswordParameterSet', Mandatory, HelpMessage = "The object Id of application.")]
        [Parameter(ParameterSetName = 'ApplicationObjectIdWithCertValueParameterSet', Mandatory, HelpMessage = "The object Id of application.")]
        [Parameter(ParameterSetName = 'ApplicationObjectIdWithKeyCredentialParameterSet', Mandatory, HelpMessage = "The object Id of application.")]
        [Parameter(ParameterSetName = 'ApplicationObjectIdWithPasswordCredentialParameterSet', Mandatory, HelpMessage = "The object Id of application.")]
        [Alias('Id')]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
        [System.String]
        ${ObjectId},

        [Parameter(ParameterSetName = 'ApplicationIdWithCertValueParameterSet', Mandatory, HelpMessage = "The application Id.")]
        [Parameter(ParameterSetName = 'ApplicationIdWithPasswordParameterSet', Mandatory, HelpMessage = "The application Id.")]
        [Parameter(ParameterSetName = 'ApplicationIdWithKeyCredentialParameterSet', Mandatory, HelpMessage = "The application Id.")]
        [Parameter(ParameterSetName = 'ApplicationIdWithPasswordCredentialParameterSet', Mandatory, HelpMessage = "The application Id.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
        [System.Guid]
        ${ApplicationId},

        [Parameter(ParameterSetName = 'DisplayNameWithPasswordParameterSet', Mandatory, HelpMessage = "The display name of application.")]
        [Parameter(ParameterSetName = 'DisplayNameWithCertValueParameterSet', Mandatory, HelpMessage = "The display name of application.")]
        [Parameter(ParameterSetName = 'DisplayNameWithKeyCredentialParameterSet', Mandatory, HelpMessage = "The display name of application.")]
        [Parameter(ParameterSetName = 'DisplayNameWithPasswordCredentialParameterSet', Mandatory, HelpMessage = "The display name of application.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
        [System.String]
        ${DisplayName},

        [Parameter(ParameterSetName = 'ApplicationObjectWithPasswordParameterSet', Mandatory, ValueFromPipeline, HelpMessage = "The application object, could be used as pipeline input.")]
        [Parameter(ParameterSetName = 'ApplicationObjectWithCertValueParameterSet', Mandatory, ValueFromPipeline, HelpMessage = "The application object, could be used as pipeline input.")]
        [Parameter(ParameterSetName = 'ApplicationObjectWithKeyCredentialParameterSet', Mandatory, ValueFromPipeline, HelpMessage = "The application object, could be used as pipeline input.")]
        [Parameter(ParameterSetName = 'ApplicationObjectWithPasswordCredentialParameterSet', Mandatory, ValueFromPipeline, HelpMessage = "The application object, could be used as pipeline input.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphApplication]
        ${ApplicationObject},

        [Parameter(ParameterSetName = 'ApplicationObjectIdWithCertValueParameterSet', Mandatory, HelpMessage = "The value of the 'asymmetric' credential type. It represents the base 64 encoded certificate.")]
        [Parameter(ParameterSetName = 'ApplicationIdWithCertValueParameterSet', Mandatory, HelpMessage = "The value of the 'asymmetric' credential type. It represents the base 64 encoded certificate.")]
        [Parameter(ParameterSetName = 'DisplayNameWithCertValueParameterSet', Mandatory, HelpMessage = "The value of the 'asymmetric' credential type. It represents the base 64 encoded certificate.")]
        [Parameter(ParameterSetName = 'ApplicationObjectWithCertValueParameterSet', Mandatory, HelpMessage = "The value of the 'asymmetric' credential type. It represents the base 64 encoded certificate.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
        [System.String]
        ${CertValue},

        [Parameter(ParameterSetName = 'ApplicationObjectIdWithKeyCredentialParameterSet', Mandatory, HelpMessage = "key credentials associated with the application.")]
        [Parameter(ParameterSetName = 'ApplicationIdWithKeyCredentialParameterSet', Mandatory, HelpMessage = "key credentials associated with the application.")]
        [Parameter(ParameterSetName = 'DisplayNameWithKeyCredentialParameterSet', Mandatory, HelpMessage = "key credentials associated with the application.")]
        [Parameter(ParameterSetName = 'ApplicationObjectWithKeyCredentialParameterSet', Mandatory, HelpMessage = "key credentials associated with the application.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphKeyCredential[]]
        ${KeyCredentials},

        [Parameter(ParameterSetName = 'ApplicationObjectIdWithPasswordCredentialParameterSet', Mandatory, HelpMessage = "Password credentials associated with the application.")]
        [Parameter(ParameterSetName = 'ApplicationIdWithPasswordCredentialParameterSet', Mandatory, HelpMessage = "Password credentials associated with the application.")]
        [Parameter(ParameterSetName = 'DisplayNameWithPasswordCredentialParameterSet', Mandatory, HelpMessage = "Password credentials associated with the application.")]
        [Parameter(ParameterSetName = 'ApplicationObjectWithPasswordCredentialParameterSet', Mandatory, HelpMessage = "Password credentials associated with the application.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphPasswordCredential[]]
        ${PasswordCredentials},

        [Parameter(ParameterSetName = 'ApplicationObjectIdWithCertValueParameterSet', HelpMessage = "The effective start date of the credential usage. The default start date value is today. For an 'asymmetric' type credential, this must be set to on or after the date that the X509 certificate is valid from.")]
        [Parameter(ParameterSetName = 'ApplicationIdWithCertValueParameterSet', HelpMessage = "The effective start date of the credential usage. The default start date value is today. For an 'asymmetric' type credential, this must be set to on or after the date that the X509 certificate is valid from.")]
        [Parameter(ParameterSetName = 'DisplayNameWithCertValueParameterSet', HelpMessage = "The effective start date of the credential usage. The default start date value is today. For an 'asymmetric' type credential, this must be set to on or after the date that the X509 certificate is valid from.")]
        [Parameter(ParameterSetName = 'ApplicationObjectWithCertValueParameterSet', HelpMessage = "The effective start date of the credential usage. The default start date value is today. For an 'asymmetric' type credential, this must be set to on or after the date that the X509 certificate is valid from.")]
        [Parameter(ParameterSetName = 'ApplicationObjectIdWithPasswordParameterSet', HelpMessage = "The effective start date of the credential usage. The default start date value is today. For an 'asymmetric' type credential, this must be set to on or after the date that the X509 certificate is valid from.")]
        [Parameter(ParameterSetName = 'ApplicationIdWithPasswordParameterSet', HelpMessage = "The effective start date of the credential usage. The default start date value is today. For an 'asymmetric' type credential, this must be set to on or after the date that the X509 certificate is valid from.")]
        [Parameter(ParameterSetName = 'DisplayNameWithPasswordParameterSet', HelpMessage = "The effective start date of the credential usage. The default start date value is today. For an 'asymmetric' type credential, this must be set to on or after the date that the X509 certificate is valid from.")]
        [Parameter(ParameterSetName = 'ApplicationObjectWithPasswordParameterSet', HelpMessage = "The effective start date of the credential usage. The default start date value is today. For an 'asymmetric' type credential, this must be set to on or after the date that the X509 certificate is valid from.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
        [System.DateTime]
        ${StartDate},

        [Parameter(ParameterSetName = 'ApplicationObjectIdWithCertValueParameterSet', HelpMessage = "The effective end date of the credential usage. The default end date value is one year from today. For an 'asymmetric' type credential, this must be set to on or before the date that the X509 certificate is valid.")]
        [Parameter(ParameterSetName = 'ApplicationIdWithCertValueParameterSet', HelpMessage = "The effective end date of the credential usage. The default end date value is one year from today. For an 'asymmetric' type credential, this must be set to on or before the date that the X509 certificate is valid.")]
        [Parameter(ParameterSetName = 'DisplayNameWithCertValueParameterSet', HelpMessage = "The effective end date of the credential usage. The default end date value is one year from today. For an 'asymmetric' type credential, this must be set to on or before the date that the X509 certificate is valid.")]
        [Parameter(ParameterSetName = 'ApplicationObjectWithCertValueParameterSet', HelpMessage = "The effective end date of the credential usage. The default end date value is one year from today. For an 'asymmetric' type credential, this must be set to on or before the date that the X509 certificate is valid.")]
        [Parameter(ParameterSetName = 'ApplicationObjectIdWithPasswordParameterSet', HelpMessage = "The effective end date of the credential usage. The default end date value is one year from today. For an 'asymmetric' type credential, this must be set to on or before the date that the X509 certificate is valid.")]
        [Parameter(ParameterSetName = 'ApplicationIdWithPasswordParameterSet', HelpMessage = "The effective end date of the credential usage. The default end date value is one year from today. For an 'asymmetric' type credential, this must be set to on or before the date that the X509 certificate is valid.")]
        [Parameter(ParameterSetName = 'DisplayNameWithPasswordParameterSet', HelpMessage = "The effective end date of the credential usage. The default end date value is one year from today. For an 'asymmetric' type credential, this must be set to on or before the date that the X509 certificate is valid.")]
        [Parameter(ParameterSetName = 'ApplicationObjectWithPasswordParameterSet', HelpMessage = "The effective end date of the credential usage. The default end date value is one year from today. For an 'asymmetric' type credential, this must be set to on or before the date that the X509 certificate is valid.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
        [System.DateTime]
        ${EndDate},

        [Parameter(ParameterSetName = 'ApplicationObjectIdWithCertValueParameterSet', HelpMessage = "Custom Key Identifier")]
        [Parameter(ParameterSetName = 'ApplicationIdWithCertValueParameterSet', HelpMessage = "Custom Key Identifier")]
        [Parameter(ParameterSetName = 'DisplayNameWithCertValueParameterSet', HelpMessage = "Custom Key Identifier")]
        [Parameter(ParameterSetName = 'ApplicationObjectWithCertValueParameterSet', HelpMessage = "Custom Key Identifier")]
        [Parameter(ParameterSetName = 'ApplicationObjectIdWithPasswordParameterSet', HelpMessage = "Custom Key Identifier")]
        [Parameter(ParameterSetName = 'ApplicationIdWithPasswordParameterSet', HelpMessage = "Custom Key Identifier")]
        [Parameter(ParameterSetName = 'DisplayNameWithPasswordParameterSet', HelpMessage = "Custom Key Identifier")]
        [Parameter(ParameterSetName = 'ApplicationObjectWithPasswordParameterSet', HelpMessage = "Custom Key Identifier")]
        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
        [System.String]
        ${CustomKeyIdentifier},

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
        if (!$PSBoundParameters['PasswordCredentials'] -and !$PSBoundParameters['KeyCredentials'] ) {
            if ($PSBoundParameters['CertValue']) {
                $credential = New-Object -TypeName "Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphKeyCredential" `
                                         -Property @{'Key' = ([System.Convert]::FromBase64String($PSBoundParameters['CertValue']));
                                            'Usage'       = 'Verify'; 
                                            'Type'        = 'AsymmetricX509Cert'
                                         }
            } else {
                $credential = New-Object -TypeName "Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphPasswordCredential"
            }
            if ($PSBoundParameters['CustomKeyIdentifier']) {
                $credential.CustomKeyIdentifier = [System.Convert]::FromBase64String($PSBoundParameters['CustomKeyIdentifier'])
                $null = $PSBoundParameters.Remove('CustomKeyIdentifier')
            }
            if ($PSBoundParameters['StartDate']) {
                $credential.StartDateTime = $PSBoundParameters['StartDate']
                $null = $PSBoundParameters.Remove('StartDate')
            }
            if ($PSBoundParameters['EndDate']) {
                $credential.EndDateTime = $PSBoundParameters['EndDate']
                $null = $PSBoundParameters.Remove('EndDate')
            }
            $credential.KeyId = (New-Guid).ToString()
            if ($PSBoundParameters['CertValue']) {
                $kc = $credential
                $null = $PSBoundParameters.Remove('CertValue')
            } else {
                $pc = $credential
            }
        } elseif ($PSBoundParameters['PasswordCredentials']) {
            $pc = $PSBoundParameters['PasswordCredentials']
            $null = $PSBoundParameters.Remove('PasswordCredentials')
        } else {
            $kc = $PSBoundParameters['KeyCredentials']
            $null = $PSBoundParameters.Remove('KeyCredentials')
        }

        $param = @{}
        switch ($PSCmdlet.ParameterSetName) {
            { $_ -in 'ApplicationObjectIdWithPasswordParameterSet', 'ApplicationObjectIdWithKeyCredentialParameterSet', 'ApplicationObjectIdWithPasswordCredentialParameterSet', 'ApplicationObjectIdWithCertValueParameterSet'} {
                $id = $PSBoundParameters['ObjectId']
                if ($kc) {
                    $app = Get-AzADApplication -ObjectId $id
                }
                $null = $PSBoundParameters.Remove('ObjectId')
                break
            }
            { $_ -in 'ApplicationIdWithPasswordParameterSet', 'ApplicationIdWithKeyCredentialParameterSet', 'ApplicationIdWithPasswordCredentialParameterSet', 'ApplicationIdWithCertValueParameterSet'} {
                $param['ApplicationId'] = $PSBoundParameters['ApplicationId']
                $app = Get-AzADApplication @param
                if ($app) {
                    $id = $app.Id
                    $null = $PSBoundParameters.Remove('ApplicationId')  
                }
                else {
                    Write-Error "application with application id '$($PSBoundParameters['ApplicationId'])' does not exist."
                    return
                }
                break
            }
            { $_ -in 'DisplayNameWithPasswordParameterSet', 'DisplayNameWithKeyCredentialParameterSet', 'DisplayNameWithPasswordCredentialParameterSet', 'DisplayNameWithCertValueParameterSet'} {
                $param['DisplayName'] = $PSBoundParameters['DisplayName']
                [System.Array]$app = Get-AzADApplication @param
                if (0 -eq $app.Count) {
                    Write-Error "application with display name '$($PSBoundParameters['DisPlayName'])' does not exist."
                    return
                }
                elseif (1 -eq $app.Count) {
                    $id = $app[0].Id
                    $null = $PSBoundParameters.Remove('DisplayName')
                }
                else {
                    Write-Error "More than one application found with display name '$($PSBoundParameters['DisplayName'])'. Please use the Get-AzADApplication cmdlet to get the object id of the desired application."
                    return
                }
                break
            }
            { $_ -in 'ApplicationObjectWithPasswordParameterSet', 'ApplicationObjectWithKeyCredentialParameterSet', 'ApplicationObjectWithPasswordCredentialParameterSet', 'ApplicationObjectWithCertValueParameterSet'} {
                $id = $PSBoundParameters['ApplicationObject'].Id
                if ($kc) {
                    $app = Get-AzADApplication -ObjectId $id
                }
                $null = $PSBoundParameters.Remove('ApplicationObject')
                break
            }
            default {
                break
            }
        }  
        if ($pc) {
            $PSBoundParameters['ApplicationId'] = $id
            foreach ($credential in $pc) {
                $PSBoundParameters['PasswordCredential'] = $credential
                Az.MSGraph.internal\Add-AzADApplicationPassword @PSBoundParameters
            }
            $null = $PSBoundParameters.Remove('ApplicationId')
            if ($PSBoundParameters['PasswordCredential']) {
                $null = $PSBoundParameters.Remove('PasswordCredential')
            }
        }
        if ($kc) {
            [System.Array]$kcList = $app.KeyCredentials
            $PSBoundParameters['Id'] = $id
            foreach ($k in $kc) {
                $kcList += $k
            }
            $PSBoundParameters['KeyCredentials'] = $kcList
            Az.MSGraph.internal\Update-AzADApplication @PSBoundParameters
        }
    }
}
# SIG # Begin signature block
# MIIoKgYJKoZIhvcNAQcCoIIoGzCCKBcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDYMuZ0QjfsTlrh
# 5NfZF0RQ8fcRZKU6ozgr7bVzqFBFmaCCDXYwggX0MIID3KADAgECAhMzAAADTrU8
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
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIKUTDcvArFP4wiuZJ3o/b/fk
# FS+rjVbPkF443QVjjimxMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAb/o8PlTKgN5zuLhs/D7f1UUK4GZ49b77DxgXJETT8PhENoCDhVaWMWHB
# 3sz408T9ZXCK0FZiphttL0f+W4r0q6qWr3CKQHiyIH6GVmSRfh1BUUCBiB5YZ58M
# fW5T2PbN5ayhe4eXO5PHNf7TloeqnL5U7fMZwGcDvpV8SAjvpww3L5VwXiSXrX4j
# TouXBFXUucWfmWrbBkvJo8lU14gETpJw24DsGc4CHVCxVGa5RTT53S/SjvDu5TVT
# js6gCS/wpT9uW09iUth0bRHjQ2zx9zmMV/RzXiaGpmIcjkoNROn9zQGEB0/7hJYb
# qXSSXxq9oHJ1vgBaPbLaSvPCo+iKA6GCF5QwgheQBgorBgEEAYI3AwMBMYIXgDCC
# F3wGCSqGSIb3DQEHAqCCF20wghdpAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFSBgsq
# hkiG9w0BCRABBKCCAUEEggE9MIIBOQIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCCT4i1dL2Fabhp4pLbBoX9IhoC9EkjxNrrPCI6m4VknyQIGZVbVi/i9
# GBMyMDIzMTEyNzA2MzEwNC42NTNaMASAAgH0oIHRpIHOMIHLMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1l
# cmljYSBPcGVyYXRpb25zMScwJQYDVQQLEx5uU2hpZWxkIFRTUyBFU046MzMwMy0w
# NUUwLUQ5NDcxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2Wg
# ghHqMIIHIDCCBQigAwIBAgITMwAAAcyGpdw369lhLQABAAABzDANBgkqhkiG9w0B
# AQsFADB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYD
# VQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDAeFw0yMzA1MjUxOTEy
# MDFaFw0yNDAyMDExOTEyMDFaMIHLMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
# aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
# cnBvcmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1lcmljYSBPcGVyYXRpb25z
# MScwJQYDVQQLEx5uU2hpZWxkIFRTUyBFU046MzMwMy0wNUUwLUQ5NDcxJTAjBgNV
# BAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2UwggIiMA0GCSqGSIb3DQEB
# AQUAA4ICDwAwggIKAoICAQDMsSIF8e9NmEc+83NVZGgWWZi/wBYt8zhxAfSGM7xw
# 7K7CbA/1A4GhovPvkIY873tnyzdyZe+6YHXx+Rd618lQDmmm5X4euiYG53Ld7WIK
# +Dd+hyi0H97D6HM4ZzGqovmwB0fZ3lh+phJLoPT+9yrTLFzkkKw2Vcb7wXMBziD0
# MVVYbmwRlRaypTntl39IENCEijW9j6MElTyXP2zrc0OthQN5RrMTY5iZja3MyHCF
# mYMGinmHftsaG3Ydi8Ga8BQjdtoTm5dVhnqs2qKNEOqZSon28R4Xff0tlJL5UHyI
# 3bywH/+zQeJu8qnsSCi8VFPOsZEb6cZzhXHaAiSGtdKAbQRaAIhExbIUpeJypC7l
# +wqKC3BO9ADGupB9ZgUFbSv5ECFjMDzbfm8M5zz2A4xYNPQXqZv0wGWL+jTvb7kF
# YiDPPe+zRyBbzmrSpObB7XqjqzUFNKlwp+Mx15k1F7FMs5EM2uG68IQsdAGBkZbS
# DmuGmjPbZ7dtim+XHuh3NS6JmXYPS7rikpCbUsMZMn5eWxiWFIk6f00skR4RLWmh
# 0N6Oq+KYI1fA59LzGiAbOrcxgvQkRo3OD4o1JW9z1TNMwEbkzPrXMo8rrGsuGoyY
# Wcsm9xhd0GXIRHHC64nzbI3e0G5jqEsWQc4uaQeSRyr70KRijzVyWjjYfsEtvVMl
# JwIDAQABo4IBSTCCAUUwHQYDVR0OBBYEFIKmHGRdPIdLRXtsR5XRSyM3+2kMMB8G
# A1UdIwQYMBaAFJ+nFV0AXmJdg/Tl0mWnG1M1GelyMF8GA1UdHwRYMFYwVKBSoFCG
# Tmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY3Jvc29mdCUy
# MFRpbWUtU3RhbXAlMjBQQ0ElMjAyMDEwKDEpLmNybDBsBggrBgEFBQcBAQRgMF4w
# XAYIKwYBBQUHMAKGUGh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY2Vy
# dHMvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3J0MAwG
# A1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwDgYDVR0PAQH/BAQD
# AgeAMA0GCSqGSIb3DQEBCwUAA4ICAQB5GUMo9XviUl3g72u8oQTorIKDoAdgWZ4L
# Q9+dAEQCmaetsThkxbNm15seu7GmwpZdhMQN8TNddGki5s5Ie+aA2VEo9vZz31ll
# usHBXAVrQtpufQqtIA+2nnusfaYviitr6p5kVT609LITOYgdKRWEpfx/4yT5R9yM
# eKxoxkk8tyGiGPZK40ST5Z14OPdJfVbkYeCvlLQclsX1+WBZNx/XZvazJmXjvYjT
# uG0QbZpxw4ZO3ZoffQYxZYRzn0z41U7MDFlXo2ihfasdbHuua6kpHxJ9AIoUevh3
# mzvUxYp0u0z3wYDPpLuo+M2VYh8XOCUB0u75xG3S5+98TKmFbqZYgpgr6P+YKeao
# 2YpB1izs850YSzuwaX7kRxAURlmN/j5Hv4wabnOfZb36mDqJp4IeGmwPtwI8tEPs
# uRAmyreejyhkZV7dfgJ4N83QBhpHVZlB4FmlJR8yF3aB15QW6tw4CaH+PMIDud6G
# eOJO4cQE+lTc6rIJmN4cfi2TTG7e49TvhCXfBS2pzOyb9YemSm0krk8jJh6zgeGq
# ztk7zewfE+3shQRc74sXLY58pvVoznfgfGvy1llbq4Oey96KouwiuhDtxuKlTnW7
# pw7xaNPhIMsOxW8dpSp915FtKfOqKR/dfJOsbHDSJY/iiJz4mWKAGoydeLM6zLmo
# hRCPWk/Q5jCCB3EwggVZoAMCAQICEzMAAAAVxedrngKbSZkAAAAAABUwDQYJKoZI
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
# MCUGA1UECxMeblNoaWVsZCBUU1MgRVNOOjMzMDMtMDVFMC1EOTQ3MSUwIwYDVQQD
# ExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNloiMKAQEwBwYFKw4DAhoDFQBO
# TuZ3uYfiihS4zRToxisDt9mJpKCBgzCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFBDQSAyMDEwMA0GCSqGSIb3DQEBCwUAAgUA6Q6CvDAiGA8yMDIzMTEyNzAyNTE0
# MFoYDzIwMjMxMTI4MDI1MTQwWjB0MDoGCisGAQQBhFkKBAExLDAqMAoCBQDpDoK8
# AgEAMAcCAQACAgO0MAcCAQACAhPHMAoCBQDpD9Q8AgEAMDYGCisGAQQBhFkKBAIx
# KDAmMAwGCisGAQQBhFkKAwKgCjAIAgEAAgMHoSChCjAIAgEAAgMBhqAwDQYJKoZI
# hvcNAQELBQADggEBAJfjyFeWtfBubQX2FBIG18ePEP40+f5z8qhq+bEqO/shA2uZ
# J04SAUqNi07fK4Wi4WhCSBjsEHDIzHaibiYn/O5IhoCUcdLryZ/qy0N2WUi5c6rI
# 9LuyGYFFdMfSNB1X5yGd5eaqZHbP+wBqmGs+/feS+2bps/g0/n9VZKqScBEkcy06
# ZnTFU9R/lvwtUURaCZWPlrR8yZqd+sIq4hR0vT3anntP94OuKAX1cmyLWzzQvgG/
# KT6R61PySIyH8xYJx7N5BqIHCfIWJAWD0maqYDbRCJPQ/8RskggG+NPvX8og+7sF
# WJOHv1MmRT/3UN2GWNbR+pK4ptcZRW76fqthUykxggQNMIIECQIBATCBkzB8MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNy
# b3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAITMwAAAcyGpdw369lhLQABAAABzDAN
# BglghkgBZQMEAgEFAKCCAUowGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8G
# CSqGSIb3DQEJBDEiBCCl57Erfajf2uPLYJiLoewxfSK9Hb/WfXm+eRF0+0xuiDCB
# +gYLKoZIhvcNAQkQAi8xgeowgecwgeQwgb0EINbuZQHC/sMCE+cgKVSkwKpDICfn
# efFZYgDbF4HrcFjmMIGYMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldh
# c2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBD
# b3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIw
# MTACEzMAAAHMhqXcN+vZYS0AAQAAAcwwIgQgIxiEY8UGbJ12KrwN0MoMk0MCQc4r
# Uf8A6xeYHxNpzS4wDQYJKoZIhvcNAQELBQAEggIAYx5cBR/Gp8jNQj3t/vxepVtc
# COYk0DCTpG+Dm5mG4FvAVu6L2p+0WuuQ6kgaYmgt9Yy5Oxyl0Fo38ts1LVPUy4WB
# Q9d0FR8yKXGSMvGifLVbq8ArUptQghfT47kKGkdALZDawFSm/oKlHOCPdsCghuoC
# V5JlnnitqStAxwCEh4KFetcj+WKoEGr0dXEhZoXxPIAglzaQNZZvXy1PHuoL8mzg
# hIh6U+MLhTfB+vAXRNUEzsXtfYpzYxysI7cfYD1HNDeZTrcpuNCOzMWiS9UbOQB9
# PIdHdARAQUhDSYa/e8t1vny9YVwqioGPhTmVZ4kdC8h4aU6ECCeiryn8NNgBk/cI
# Za1zWnp6RsobGxlSksmY4v4q6yCkKcfg1iq6KaTfJpptxaMlUgZr+iCc451PEpMr
# up1fYDVlgzWyiz3J2lcxoQhV1GTM59iL+3SuYlUq9KEAhzM0yGzSeA/hpMGrBg0G
# EhW3WByfzxWSXFTPUSSixHL9nBTyyhMQg8JvP9di092YejhO+h5xOzhw/CBYdp0U
# agaLZtVAp9+B+aYlq5GND9HnskV1mYw4lFkX6G3nO3FRRR9YhCjTcysii9L+XXZd
# illvFLQtaqs4W+SzXTQqH4j2LeJ7QJnd9JxiIb7BE4c1zhJNLg1+kb78W4yP2DEb
# cAFCwscqLQmWXFdEg3w=
# SIG # End signature block
