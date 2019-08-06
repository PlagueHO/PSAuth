function Invoke-PSAuthRestMethod
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Uri]
        $Uri,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $OauthConsumerKey,

        [Parameter(Mandatory = $true)]
        [System.Security.SecureString]
        $OauthConsumerSecret,

        [Parameter(Mandatory = $false)]
        [System.String]
        $OauthAccessToken,

        [Parameter(Mandatory = $false)]
        [System.Security.SecureString]
        $OauthAccessTokenSecret,

        [Parameter(Mandatory = $false)]
        [ValidateSet('HMAC-SHA1', 'HMAC-SHA256')]
        [System.String]
        $OauthSignatureMethod = 'HMAC-SHA1',

        [Parameter(Mandatory = $false)]
        [ValidateSet('1.0')]
        [System.String]
        $OauthVersion = '1.0',

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable]
        $OauthParameters = @{},

        [Parameter(Mandatory = $false)]
        [ValidateSet('Default', 'Delete', 'Get', 'Head', 'Merge', 'Options', 'Patch', 'Post', 'Put', 'Trace')]
        [System.String]
        $Method = 'Get',

        [Parameter(Mandatory = $false)]
        [System.String]
        $ContentType,

        [Parameter(Mandatory = $false)]
        [System.String]
        $Body,

        [Parameter(Mandatory = $false)]
        [System.Collections.IDictionary]
        $Headers,

        [Parameter(Mandatory = $false)]
        [System.String]
        $Proxy,

        [Parameter(Mandatory = $false)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.CredentialAttribute()]
        $ProxyCredential,

        [Parameter(Mandatory = $false)]
        [Switch]
        $ProxyUseDefaultCredentials,

        [Parameter(Mandatory = $false)]
        [Switch]
        $DisableKeepAlive
    )

    $getPSAuthorizationString = @{ } + $PSBoundParameters
    @(
        'Body'
        'ContentType'
        'DisableKeepAlive'
        'Headers'
        'Proxy'
        'ProxyCredential'
        'ProxyUseDefaultCredentials'
     ) | ForEach-Object -Process { $null = $getPSAuthorizationString.Remove($_) }

    $authorization = Get-PSAuthorizationString @getPSAuthorizationString

    # Take all the parameters passed to this function and pass them to
    $invokeRestMethodParameters = @{ } + $PSBoundParameters

    $headers += @{ 'Authorization' = $authorization }

    # Remove parameters that should not be passed to Invoke-RestMethod
    $null = $invokeRestMethodParameters.Remove('OauthConsumerKey')
    $null = $invokeRestMethodParameters.Remove('OauthConsumerSecret')
    $null = $invokeRestMethodParameters.Remove('OauthAccessToken')
    $null = $invokeRestMethodParameters.Remove('OauthAccessTokenSecret')
    $null = $invokeRestMethodParameters.Remove('OauthSignatureMethod')
    $null = $invokeRestMethodParameters.Remove('OauthVersion')
    $null = $invokeRestMethodParameters.Remove('OauthParameters')

    if ($method -notin 'POST', 'PUT')
    {
        # Remove Body parameter for all methods except POST and PUT
        $null = $invokeRestMethodParameters.Remove('Body')
    }

    $null = $invokeRestMethodParameters['Headers'] = $headers

    return Invoke-RestMethod @invokeRestMethodParameters
}
