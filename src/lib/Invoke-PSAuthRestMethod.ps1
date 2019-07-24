<#
    .Synopsis
    The primary OAuth function

    .Parameter Uri
    The URI which will be invoked against

    .Parameter ConsumerKey
    The OAuth Consumer Key (a key specific to the application requesting access)

    .Parameter ConsumerSecret
    The OAuth Consumer Secret (the secret part of the application's consumer key shouldn't be given to end users)

    .Parameter Method
    The HTTP verb which will be invoked (defaults to GET)
 #>
function Invoke-PSAuthRestMethod
{
    [CmdletBinding()]
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
        [System.Security.SecureString]
        $OauthAccessToken,

        [Parameter(Mandatory = $false)]
        [System.Security.SecureString]
        $OauthAccessTokenSecret,

        [Parameter(Mandatory = $false)]
        [ValidateSet('HMAC-SHA1')]
        [System.String]
        $OauthSignatureMethod = 'HMAC-SHA1',

        [Parameter(Mandatory = $false)]
        [ValidateSet('1.0')]
        [System.String]
        $OauthVersion = '1.0',

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable]
        $Parameters = @{},

        [Parameter(Mandatory = $false)]
        [ValidateSet('POST', 'GET', 'PUT', 'DELETE', 'HEAD', 'OPTIONS')]
        [System.String]
        $Method = 'GET',

        [Parameter(Mandatory = $false)]
        [ValidateSet('application/json', 'multipart/form-data')]
        [System.String]
        $ContentType = 'application/json',

        [Parameter(Mandatory = $false)]
        [System.String]
        $Body,

        [Parameter(Mandatory = $false)]
        [System.String]
        $Proxy,

        [Parameter(Mandatory = $false)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.CredentialAttribute()]
        $ProxyCredential,

        [Parameter(Mandatory = $false)]
        [Switch]
        $ProxyUseDefaultCredentials
    )

    $Method = $Method.ToUpper()
    $normalizedUri = Get-PSAuthNormalizedUri -Uri $Uri
    $oauthTimestamp = Get-PSAuthTimestamp
    $oauthNonce = Get-PSAuthNonce

    # Create a hash table containing the basic OAuth info to include in the signature
    $signatureKeys = @{
        oauth_consumer_key     = $OauthConsumerKey
        oauth_signature_method = $OauthSignatureMethod
        oauth_timestamp        = $oauthTimestamp
        oauth_nonce            = $oauthNonce
        oauth_version          = $OauthVersion
    }

    # If an access token is specified add that to the signature
    if ($PSBoundParameters.ContainsKey($AccessToken))
    {
        $signatureKeys += @{ oauth_token = $OauthAccessToken }
    }

    # Add any optional parameters to the signature
    foreach ($parameter in $Parameters.GetEnumerator())
    {
        $signatureKeys += @{ $parameter.Name = [System.Uri]::EscapeDataString($parameter.Value) }
    }

    # If any query string parameters are passed include these in the signature
    if ($Uri.Query)
    {
        $signatureKeys += Convert-PSAuthStringToHashTable -String $Uri.Query.TrimStart('?')
    }

    # Serialize all the parameters into a string ordered by Name, Value
    $orderedRequestParameters = Convert-PSAuthHashTableToString -HashTable $signatureKeys -Sort 'Name', 'Value'
    $normalizedRequestParameters = [System.Uri]::EscapeDataString($orderedRequestParameters)

    # Generate the signature
    $signature = '{0}&{1}&{2}' -f $Method, [System.Uri]::EscapeDataString($normalizedUri), $normalizedRequestParameters
    $signatureKey = '{0}&{1}' -f [System.Uri]::EscapeDataString($OauthConsumerSecret), [System.Uri]::EscapeDataString($OauthAccessSecret)

    # Select the Signature method
    switch ($OauthSignatureMethod)
    {
        'HMAC-SHA1'
        {
            $hash = New-Object -TypeName System.Security.Cryptography.HMACSHA1
        }
    }

    $hash.Key = [System.Text.Encoding]::Ascii.GetBytes($signatureKey)
    $oauthSignature = [System.Convert]::ToBase64String($hash.ComputeHash([System.Text.Encoding]::ASCII.GetBytes($signature)))

    # Now assemble the authorization hash table including parameters
    $authorization += @{
        oauth_consumer_key     = [System.Uri]::EscapeDataString($OauthConsumerKey)
        oauth_nonce            = $oauthNonce
        oauth_signature        = [System.Uri]::EscapeDataString($OauthSignature)
        oauth_signature_method = $OauthSignatureMethod
        oauth_timestamp        = $oauthTimestamp
    }

    if ($PSBoundParameters.ContainsKey($OauthAccessToken))
    {
        $authorization += @{ oauth_token = $OauthAccessToken }
    }

    $authorization += @{ oauth_version = $OauthVersion }
    $authorizationString = Convert-PSAuthHashTableToString -HashTable $authorization -PairSeparator '", ' -KeyValueSeparator '="'

    if ($ContentType -eq 'multipart/form-data')
    {
        $headers = @{ 'Content-Type' = ('{0}; boundary=--------------------------022142622625170180392785' -f $ContentType) }
    }
    else
    {

        $headers = @{ 'Content-Type' = $ContentType }
    }

    $headers += @{ 'Authorization' = 'OAuth {0}"' -f $authorizationString }
    $headers += @{ 'Accept' = 'application/json' }

    # Take all the parameters passed to this function and pass them to
    $invokeRestMethodParameters = @{ } + $PSBoundParameters

    # Remove parameters that should not be passed to Invoke-RestMethod
    $null = $invokeRestMethodParameters.Remove('OauthConsumerKey')
    $null = $invokeRestMethodParameters.Remove('OauthConsumerSecret')
    $null = $invokeRestMethodParameters.Remove('OauthAccessToken')
    $null = $invokeRestMethodParameters.Remove('OauthAccessTokenSecret')

    if ($method -notin 'POST', 'PUT')
    {
        # Remove Body parameter for all methods except POST and PUT
        $null = $invokeRestMethodParameters.Remove('Body')
    }

    $null = $invokeRestMethodParameters.Add('Headers', $headers)

    return Invoke-RestMethod @PSBoundParameters -DisableKeepAlive
}
