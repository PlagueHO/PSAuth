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
    $script:testUri = [System.Uri]::new('https://contoso.com/api/oauth1/get')
    $script:testOauthConsumerKey = 'NotRealTestKey'
    $script:testOauthConsumerSecret = ConvertTo-SecureString -String 'NotRealTestSecret' -AsPlainText -Force
    $script:testOauthAccessToken = 'NotRealAccessToken'
    $script:testOauthAccessTokenSecret = ConvertTo-SecureString -String 'NotRealTestTokenSecret' -AsPlainText -Force
    $script:testOauthNonce = '0d9ce393ab5e4a08ad20df98aa4b2c06'
    $script:testOauthTimestamp = '1563952713'

    Describe 'Invoke-PSAuthRestMethod' -Tag 'Unit' {
        It 'Should exist' {
            { Get-Command -Name Invoke-PSAuthRestMethod -ErrorAction Stop } | Should -Not -Throw
        }

        Context 'When called without proxy parameters' {
            BeforeAll {
                Mock -CommandName Get-PSAuthNonce `
                    -MockWith { $script:testOauthNonce }

                Mock -CommandName Get-PSAuthTimestamp `
                    -MockWith { $script:testOauthTimestamp }
            }

            Context 'When called with Oauth Consumer Key, Consumer Secret, signature method of HMAC-SHA1 and version 1.0' {
                Context 'When called with GET method' {
                    Mock -CommandName Invoke-RestMethod `
                        -MockWith { 'Test Result' }

                    It 'Should not throw exception' {
                        {
                            $invokePSAuthRestMethodParameters = @{
                                Uri                 = $script:testUri
                                OauthConsumerKey    = $script:testOauthConsumerKey
                                OauthConsumerSecret = $script:testOauthConsumerSecret
                                Method              = 'get'
                                Verbose             = $true
                            }

                            $script:invokePSAuthRestMethodResult = Invoke-PSAuthRestMethod @invokePSAuthRestMethodParameters
                        } | Should -Not -Throw
                    }

                    It 'Should return the result from Invoke-RestMethod' {
                        $script:invokePSAuthRestMethodResult | Should -Be 'Test Result'
                    }

                    It 'Should call Invoke-RestMethod with expected parameters' {
                        Assert-MockCalled -CommandName Invoke-RestMethod `
                            -ParameterFilter {
                            $Headers['Authorization'] -eq 'OAuth oauth_consumer_key="NotRealTestKey",oauth_nonce="0d9ce393ab5e4a08ad20df98aa4b2c06",oauth_signature="X5wrDBIFlmxyF1rMVN3Juvp7Ncc%3D",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1563952713",oauth_version="1.0"' -and `
                                $Method -eq 'GET' -and `
                                $null -eq $Body
                        } `
                            -Exactly -Times 1
                    }
                }

                Context 'When called with POST method and a valid body' {
                    Mock -CommandName Invoke-RestMethod `
                        -MockWith { 'Test Result' }

                    It 'Should not throw exception' {
                        {
                            $invokePSAuthRestMethodParameters = @{
                                Uri                 = $script:testUri
                                OauthConsumerKey    = $script:testOauthConsumerKey
                                OauthConsumerSecret = $script:testOauthConsumerSecret
                                Method              = 'post'
                                Body                = 'body'
                                Verbose             = $true
                            }

                            $script:invokePSAuthRestMethodResult = Invoke-PSAuthRestMethod @invokePSAuthRestMethodParameters
                        } | Should -Not -Throw
                    }

                    It 'Should return the result from Invoke-RestMethod' {
                        $script:invokePSAuthRestMethodResult | Should -Be 'Test Result'
                    }

                    It 'Should call Invoke-RestMethod with expected parameters' {
                        Assert-MockCalled -CommandName Invoke-RestMethod `
                            -ParameterFilter {
                            $Headers['Authorization'] -eq 'OAuth oauth_consumer_key="NotRealTestKey",oauth_nonce="0d9ce393ab5e4a08ad20df98aa4b2c06",oauth_signature="YK95uO6uqulpjJcQX9ONMWGoU8A%3D",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1563952713",oauth_version="1.0"' -and `
                                $Method -eq 'POST' -and `
                                $Body -eq $body
                        } `
                            -Exactly -Times 1
                    }
                }

                Context 'When called with POST method and a valid body and header' {
                    Mock -CommandName Invoke-RestMethod `
                        -MockWith { 'Test Result' }

                    It 'Should not throw exception' {
                        {
                            $invokePSAuthRestMethodParameters = @{
                                Uri                 = $script:testUri
                                OauthConsumerKey    = $script:testOauthConsumerKey
                                OauthConsumerSecret = $script:testOauthConsumerSecret
                                Method              = 'post'
                                Body                = 'body'
                                Headers             = @{ TestHeader = 'TestValue' }
                                Verbose             = $true
                            }

                            $script:invokePSAuthRestMethodResult = Invoke-PSAuthRestMethod @invokePSAuthRestMethodParameters
                        } | Should -Not -Throw
                    }

                    It 'Should return the result from Invoke-RestMethod' {
                        $script:invokePSAuthRestMethodResult | Should -Be 'Test Result'
                    }

                    It 'Should call Invoke-RestMethod with expected parameters' {
                        Assert-MockCalled -CommandName Invoke-RestMethod `
                            -ParameterFilter {
                            $Headers['Authorization'] -eq 'OAuth oauth_consumer_key="NotRealTestKey",oauth_nonce="0d9ce393ab5e4a08ad20df98aa4b2c06",oauth_signature="YK95uO6uqulpjJcQX9ONMWGoU8A%3D",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1563952713",oauth_version="1.0"' -and `
                                $Headers['TestHeader'] -eq 'TestValue' -and `
                                $Method -eq 'POST' -and `
                                $Body -eq $body
                        } `
                            -Exactly -Times 1
                    }
                }
            }

            Context 'When called with Oauth Consumer Key, Consumer Secret, Access Token, signature method of HMAC-SHA1 and version 1.0' {
                Context 'When called with GET method' {
                    Mock -CommandName Invoke-RestMethod `
                        -MockWith { 'Test Result' }

                    It 'Should not throw exception' {
                        {
                            $invokePSAuthRestMethodParameters = @{
                                Uri                 = $script:testUri
                                OauthConsumerKey    = $script:testOauthConsumerKey
                                OauthConsumerSecret = $script:testOauthConsumerSecret
                                OauthAccessToken    = $script:testOauthAccessToken
                                Method              = 'get'
                                Verbose             = $true
                            }

                            $script:invokePSAuthRestMethodResult = Invoke-PSAuthRestMethod @invokePSAuthRestMethodParameters
                        } | Should -Not -Throw
                    }

                    It 'Should return the result from Invoke-RestMethod' {
                        $script:invokePSAuthRestMethodResult | Should -Be 'Test Result'
                    }

                    It 'Should call Invoke-RestMethod with expected parameters' {
                        Assert-MockCalled -CommandName Invoke-RestMethod `
                            -ParameterFilter {
                            $Headers['Authorization'] -eq 'OAuth oauth_consumer_key="NotRealTestKey",oauth_nonce="0d9ce393ab5e4a08ad20df98aa4b2c06",oauth_signature="EaD32gGx5EsypfUCakLUd7BGHfk%3D",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1563952713",oauth_token="NotRealAccessToken",oauth_version="1.0"' -and `
                                $Method -eq 'GET' -and `
                                $null -eq $Body
                        } `
                            -Exactly -Times 1
                    }
                }

                Context 'When called with POST method and a valid body' {
                    Mock -CommandName Invoke-RestMethod `
                        -MockWith { 'Test Result' }

                    It 'Should not throw exception' {
                        {
                            $invokePSAuthRestMethodParameters = @{
                                Uri                 = $script:testUri
                                OauthConsumerKey    = $script:testOauthConsumerKey
                                OauthConsumerSecret = $script:testOauthConsumerSecret
                                OauthAccessToken    = $script:testOauthAccessToken
                                Method              = 'post'
                                Body                = 'body'
                                Verbose             = $true
                            }

                            $script:invokePSAuthRestMethodResult = Invoke-PSAuthRestMethod @invokePSAuthRestMethodParameters
                        } | Should -Not -Throw
                    }

                    It 'Should return the result from Invoke-RestMethod' {
                        $script:invokePSAuthRestMethodResult | Should -Be 'Test Result'
                    }

                    It 'Should call Invoke-RestMethod with expected parameters' {
                        Assert-MockCalled -CommandName Invoke-RestMethod `
                            -ParameterFilter {
                            $Headers['Authorization'] -eq 'OAuth oauth_consumer_key="NotRealTestKey",oauth_nonce="0d9ce393ab5e4a08ad20df98aa4b2c06",oauth_signature="uzFTFNxIHwAzBOQFk%2BNeBtVPD%2FU%3D",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1563952713",oauth_token="NotRealAccessToken",oauth_version="1.0"' -and `
                                $Method -eq 'POST' -and `
                                $Body -eq $body
                        } `
                            -Exactly -Times 1
                    }
                }

                Context 'When called with POST method and a valid body and header' {
                    Mock -CommandName Invoke-RestMethod `
                        -MockWith { 'Test Result' }

                    It 'Should not throw exception' {
                        {
                            $invokePSAuthRestMethodParameters = @{
                                Uri                 = $script:testUri
                                OauthConsumerKey    = $script:testOauthConsumerKey
                                OauthConsumerSecret = $script:testOauthConsumerSecret
                                OauthAccessToken    = $script:testOauthAccessToken
                                Method              = 'post'
                                Body                = 'body'
                                Headers             = @{ TestHeader = 'TestValue' }
                                Verbose             = $true
                            }

                            $script:invokePSAuthRestMethodResult = Invoke-PSAuthRestMethod @invokePSAuthRestMethodParameters
                        } | Should -Not -Throw
                    }

                    It 'Should return the result from Invoke-RestMethod' {
                        $script:invokePSAuthRestMethodResult | Should -Be 'Test Result'
                    }

                    It 'Should call Invoke-RestMethod with expected parameters' {
                        Assert-MockCalled -CommandName Invoke-RestMethod `
                            -ParameterFilter {
                            $Headers['Authorization'] -eq 'OAuth oauth_consumer_key="NotRealTestKey",oauth_nonce="0d9ce393ab5e4a08ad20df98aa4b2c06",oauth_signature="uzFTFNxIHwAzBOQFk%2BNeBtVPD%2FU%3D",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1563952713",oauth_token="NotRealAccessToken",oauth_version="1.0"' -and `
                                $Headers['TestHeader'] -eq 'TestValue' -and `
                                $Method -eq 'POST' -and `
                                $Body -eq $body
                        } `
                            -Exactly -Times 1
                    }
                }
            }

            Context 'When called with Oauth Consumer Key, Consumer Secret, Access Token Secret, signature method of HMAC-SHA1 and version 1.0' {
                Context 'When called with GET method' {
                    Mock -CommandName Invoke-RestMethod `
                        -MockWith { 'Test Result' }

                    It 'Should not throw exception' {
                        {
                            $invokePSAuthRestMethodParameters = @{
                                Uri                    = $script:testUri
                                OauthConsumerKey       = $script:testOauthConsumerKey
                                OauthConsumerSecret    = $script:testOauthConsumerSecret
                                OauthAccessTokenSecret = $script:testOauthAccessTokenSecret
                                Method                 = 'get'
                                Verbose                = $true
                            }

                            $script:invokePSAuthRestMethodResult = Invoke-PSAuthRestMethod @invokePSAuthRestMethodParameters
                        } | Should -Not -Throw
                    }

                    It 'Should return the result from Invoke-RestMethod' {
                        $script:invokePSAuthRestMethodResult | Should -Be 'Test Result'
                    }

                    It 'Should call Invoke-RestMethod with expected parameters' {
                        Assert-MockCalled -CommandName Invoke-RestMethod `
                            -ParameterFilter {
                            $Headers['Authorization'] -eq 'OAuth oauth_consumer_key="NotRealTestKey",oauth_nonce="0d9ce393ab5e4a08ad20df98aa4b2c06",oauth_signature="fCjn%2BElKq8OeAino9WZsZ%2BwRPAo%3D",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1563952713",oauth_version="1.0"' -and `
                                $Method -eq 'GET' -and `
                                $null -eq $Body
                        } `
                            -Exactly -Times 1
                    }
                }

                Context 'When called with POST method and a valid body' {
                    Mock -CommandName Invoke-RestMethod `
                        -MockWith { 'Test Result' }

                    It 'Should not throw exception' {
                        {
                            $invokePSAuthRestMethodParameters = @{
                                Uri                    = $script:testUri
                                OauthConsumerKey       = $script:testOauthConsumerKey
                                OauthConsumerSecret    = $script:testOauthConsumerSecret
                                OauthAccessTokenSecret = $script:testOauthAccessTokenSecret
                                Method                 = 'post'
                                Body                   = 'body'
                                Verbose                = $true
                            }

                            $script:invokePSAuthRestMethodResult = Invoke-PSAuthRestMethod @invokePSAuthRestMethodParameters
                        } | Should -Not -Throw
                    }

                    It 'Should return the result from Invoke-RestMethod' {
                        $script:invokePSAuthRestMethodResult | Should -Be 'Test Result'
                    }

                    It 'Should call Invoke-RestMethod with expected parameters' {
                        Assert-MockCalled -CommandName Invoke-RestMethod `
                            -ParameterFilter {
                            $Headers['Authorization'] -eq 'OAuth oauth_consumer_key="NotRealTestKey",oauth_nonce="0d9ce393ab5e4a08ad20df98aa4b2c06",oauth_signature="VIMW0GV%2B6BpcBFgKJ4wRq%2B64Neg%3D",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1563952713",oauth_version="1.0"' -and `
                                $Method -eq 'POST' -and `
                                $Body -eq $body
                        } `
                            -Exactly -Times 1
                    }
                }

                Context 'When called with POST method and a valid body and header' {
                    Mock -CommandName Invoke-RestMethod `
                        -MockWith { 'Test Result' }

                    It 'Should not throw exception' {
                        {
                            $invokePSAuthRestMethodParameters = @{
                                Uri                    = $script:testUri
                                OauthConsumerKey       = $script:testOauthConsumerKey
                                OauthConsumerSecret    = $script:testOauthConsumerSecret
                                OauthAccessTokenSecret = $script:testOauthAccessTokenSecret
                                Method                 = 'post'
                                Body                   = 'body'
                                Headers                = @{ TestHeader = 'TestValue' }
                                Verbose                = $true
                            }

                            $script:invokePSAuthRestMethodResult = Invoke-PSAuthRestMethod @invokePSAuthRestMethodParameters
                        } | Should -Not -Throw
                    }

                    It 'Should return the result from Invoke-RestMethod' {
                        $script:invokePSAuthRestMethodResult | Should -Be 'Test Result'
                    }

                    It 'Should call Invoke-RestMethod with expected parameters' {
                        Assert-MockCalled -CommandName Invoke-RestMethod `
                            -ParameterFilter {
                            $Headers['Authorization'] -eq 'OAuth oauth_consumer_key="NotRealTestKey",oauth_nonce="0d9ce393ab5e4a08ad20df98aa4b2c06",oauth_signature="VIMW0GV%2B6BpcBFgKJ4wRq%2B64Neg%3D",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1563952713",oauth_version="1.0"' -and `
                                $Headers['TestHeader'] -eq 'TestValue' -and `
                                $Method -eq 'POST' -and `
                                $Body -eq $body
                        } `
                            -Exactly -Times 1
                    }
                }
            }

            Context 'When called with Oauth Consumer Key, Consumer Secret, signature method of HMAC-SHA256 and version 1.0' {
                Context 'When called with GET method' {
                    Mock -CommandName Invoke-RestMethod `
                        -MockWith { 'Test Result' }

                    It 'Should not throw exception' {
                        {
                            $invokePSAuthRestMethodParameters = @{
                                Uri                  = $script:testUri
                                OauthConsumerKey     = $script:testOauthConsumerKey
                                OauthConsumerSecret  = $script:testOauthConsumerSecret
                                OauthSignatureMethod = 'HMAC-SHA256'
                                Method               = 'get'
                                Verbose              = $true
                            }

                            $script:invokePSAuthRestMethodResult = Invoke-PSAuthRestMethod @invokePSAuthRestMethodParameters
                        } | Should -Not -Throw
                    }

                    It 'Should return the result from Invoke-RestMethod' {
                        $script:invokePSAuthRestMethodResult | Should -Be 'Test Result'
                    }

                    It 'Should call Invoke-RestMethod with expected parameters' {
                        Assert-MockCalled -CommandName Invoke-RestMethod `
                            -ParameterFilter {
                            $Headers['Authorization'] -eq 'OAuth oauth_consumer_key="NotRealTestKey",oauth_nonce="0d9ce393ab5e4a08ad20df98aa4b2c06",oauth_signature="b6tms%2FOpbm2dD1vDHYqAcSFAWqwTv4puJst%2BGaN0HNg%3D",oauth_signature_method="HMAC-SHA256",oauth_timestamp="1563952713",oauth_version="1.0"' -and `
                                $Method -eq 'GET' -and `
                                $null -eq $Body
                        } `
                            -Exactly -Times 1
                    }
                }

                Context 'When called with POST method and a valid body' {
                    Mock -CommandName Invoke-RestMethod `
                        -MockWith { 'Test Result' }

                    It 'Should not throw exception' {
                        {
                            $invokePSAuthRestMethodParameters = @{
                                Uri                  = $script:testUri
                                OauthConsumerKey     = $script:testOauthConsumerKey
                                OauthConsumerSecret  = $script:testOauthConsumerSecret
                                OauthSignatureMethod = 'HMAC-SHA256'
                                Method               = 'post'
                                Body                 = 'body'
                                Verbose              = $true
                            }

                            $script:invokePSAuthRestMethodResult = Invoke-PSAuthRestMethod @invokePSAuthRestMethodParameters
                        } | Should -Not -Throw
                    }

                    It 'Should return the result from Invoke-RestMethod' {
                        $script:invokePSAuthRestMethodResult | Should -Be 'Test Result'
                    }

                    It 'Should call Invoke-RestMethod with expected parameters' {
                        Assert-MockCalled -CommandName Invoke-RestMethod `
                            -ParameterFilter {
                            $Headers['Authorization'] -eq 'OAuth oauth_consumer_key="NotRealTestKey",oauth_nonce="0d9ce393ab5e4a08ad20df98aa4b2c06",oauth_signature="s4SL%2BpOMlOqYdVpIxXQVgNmoyqApx2dKP1UzHN6iNOo%3D",oauth_signature_method="HMAC-SHA256",oauth_timestamp="1563952713",oauth_version="1.0"' -and `
                                $Method -eq 'POST' -and `
                                $Body -eq $body
                        } `
                            -Exactly -Times 1
                    }
                }

                Context 'When called with POST method and a valid body and header' {
                    Mock -CommandName Invoke-RestMethod `
                        -MockWith { 'Test Result' }

                    It 'Should not throw exception' {
                        {
                            $invokePSAuthRestMethodParameters = @{
                                Uri                  = $script:testUri
                                OauthConsumerKey     = $script:testOauthConsumerKey
                                OauthConsumerSecret  = $script:testOauthConsumerSecret
                                OauthSignatureMethod = 'HMAC-SHA256'
                                Method               = 'post'
                                Body                 = 'body'
                                Headers              = @{ TestHeader = 'TestValue' }
                                Verbose              = $true
                            }

                            $script:invokePSAuthRestMethodResult = Invoke-PSAuthRestMethod @invokePSAuthRestMethodParameters
                        } | Should -Not -Throw
                    }

                    It 'Should return the result from Invoke-RestMethod' {
                        $script:invokePSAuthRestMethodResult | Should -Be 'Test Result'
                    }

                    It 'Should call Invoke-RestMethod with expected parameters' {
                        Assert-MockCalled -CommandName Invoke-RestMethod `
                            -ParameterFilter {
                            $Headers['Authorization'] -eq 'OAuth oauth_consumer_key="NotRealTestKey",oauth_nonce="0d9ce393ab5e4a08ad20df98aa4b2c06",oauth_signature="s4SL%2BpOMlOqYdVpIxXQVgNmoyqApx2dKP1UzHN6iNOo%3D",oauth_signature_method="HMAC-SHA256",oauth_timestamp="1563952713",oauth_version="1.0"' -and `
                                $Headers['TestHeader'] -eq 'TestValue' -and `
                                $Method -eq 'POST' -and `
                                $Body -eq $body
                        } `
                            -Exactly -Times 1
                    }
                }
            }
        }
    }
}

