[System.Diagnostics.CodeAnalysis.SuppressMessage('PSAvoidUsingConvertToSecureStringWithPlainText', '')]
[CmdletBinding()]
param (
)

$ModuleName = 'PSAuth'
$ModuleManifestName = "$ModuleName.psd1"
$ModuleManifestPath = "$PSScriptRoot\..\..\src\$ModuleManifestName"

Import-Module -Name $ModuleManifestPath -Force

InModuleScope $ModuleName {
    # Variables for use in tests
    $script:testUri = [System.Uri]::new('https://na4.smartcommunications.cloud/one/oauth1/cms/v5/import/prepare')
    $script:testConsumerKey = 'NotRealTestKey'
    $script:testConsumerSecret = ConvertTo-SecureString -String 'NotRealTestSecret' -AsPlainText -Force

    Describe 'Invoke-PSAuthRestMethod' -Tag 'Unit' {
        It 'Should exist' {
            { Get-Command -Name Invoke-PSAuthRestMethod -ErrorAction Stop } | Should -Not -Throw
        }

        Context 'When called without proxy parameters' {
            Context 'When called with GET method, an absolute URI and no body' {
                Mock -CommandName Invoke-RestMethod `
                    -MockWith { 'Test Result' }

                It 'Should not throw exception'{
                    {
                        $invokeIagDmsOauthHttpRequestParameters = @{
                            Uri = $script:testUri
                            OauthConsumerKey = $script:testConsumerKey
                            OauthConsumerSecret = $script:testConsumerSecret
                            Method = 'get'
                            Verbose = $true
                        }

                        $script:invokeIagDmsOauthHttpRequestResult = Invoke-PSAuthRestMethod @invokeIagDmsOauthHttpRequestParameters
                    } | Should -Not -Throw
                }

                It 'Should return the result from Invoke-RestMethod' {
                    $script:invokeIagDmsOauthHttpRequestResult | Should -Be 'Test Result'
                }

                It 'Should call Invoke-RestMethod with expected parameters' {
                    Assert-MockCalled -CommandName Invoke-RestMethod `
                        -ParameterFilter {
                            Write-Verbose -Message $Headers -Verbose
                        }
                }
            }
        }
    }
}

