function Get-PSAuthorizationString
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
        $OauthParameters = @{ },

        [Parameter(Mandatory = $false)]
        [ValidateSet('Default', 'Delete', 'Get', 'Head', 'Merge', 'Options', 'Patch', 'Post', 'Put', 'Trace')]
        [System.String]
        $Method = 'Get'
    )

    $Method = $Method.ToUpper()
    $normalizedUri = Get-PSAuthNormalizedUri -Uri $Uri
    $oauthTimestamp = Get-PSAuthTimestamp
    $oauthNonce = Get-PSAuthNonce

    # Create a hash table containing the parameters to include in the signature
    $signatureParameters = @{
        oauth_consumer_key     = $OauthConsumerKey
        oauth_signature_method = $OauthSignatureMethod
        oauth_timestamp        = $oauthTimestamp
        oauth_nonce            = $oauthNonce
        oauth_version          = $OauthVersion
    }

    # If an access token is specified add that to the signature parameters
    if ($PSBoundParameters.ContainsKey('OauthAccessToken'))
    {
        $signatureParameters += @{ oauth_token = $OauthAccessToken }
    }

    # Add any optional Oauth parameters to the signature parameters
    foreach ($oauthParameter in $OauthParameters.GetEnumerator())
    {
        $signatureParameters += @{ $oauthParameter.Name = $oauthParameter.Value }
    }

    # If any query string parameters are passed include these in the signature parameters
    if ($Uri.Query)
    {
        foreach ($queryItem in $Uri.Query.TrimStart('?').Split('='))
        {
            $key, $value = $queryItem.split($KeyValueSeparator, 2)
            $signatureParameters += @{ $key = $value }
        }
    }

    # Serialize all the signature parameters into a string ordered by Name
    $orderedSignatureParameters = $signatureParameters.GetEnumerator() | Sort-Object -Property Name
    $paritallySerializedSignatureParameters = $orderedSignatureParameters | Foreach-Object -Process { '{0}={1}' -f $_.Name, $_.Value }
    $serializedSignatureParameters = $paritallySerializedSignatureParameters -join '&'

    # Generate the signature
    $signature = '{0}&{1}&{2}' -f $Method, [System.Uri]::EscapeDataString($normalizedUri), [System.Uri]::EscapeDataString($serializedSignatureParameters)
    $signatureKey = '{0}&' -f [System.Uri]::EscapeDataString((ConvertFrom-PSAuthSecureString -SecureString $OauthConsumerSecret))

    if ($PSBoundParameters.ContainsKey('OauthAccessTokenSecret'))
    {
        $signatureKey += [System.Uri]::EscapeDataString((ConvertFrom-PSAuthSecureString -SecureString $OauthAccessTokenSecret))
    }

    # Select the Signature method
    switch ($OauthSignatureMethod)
    {
        'HMAC-SHA1'
        {
            $signatureHashGenerator = New-Object -TypeName System.Security.Cryptography.HMACSHA1
        }

        'HMAC-SHA256'
        {
            $signatureHashGenerator = New-Object -TypeName System.Security.Cryptography.HMACSHA256
        }

    }

    $signatureHashGenerator.Key = [System.Text.Encoding]::Ascii.GetBytes($signatureKey)
    $oauthSignature = [System.Convert]::ToBase64String($signatureHashGenerator.ComputeHash([System.Text.Encoding]::ASCII.GetBytes($signature)))
    $escapedOauthSignature = [System.Uri]::EscapeDataString($oauthSignature)

    # Now assemble the authorization hash table including parameters
    $authorizationParameters = @{
        oauth_consumer_key     = [System.Uri]::EscapeDataString($OauthConsumerKey)
        oauth_nonce            = $oauthNonce
        oauth_signature        = $escapedOauthSignature
        oauth_signature_method = $OauthSignatureMethod
        oauth_timestamp        = $oauthTimestamp
        oauth_version          = $OauthVersion
    }

    if ($PSBoundParameters.ContainsKey('OauthAccessToken'))
    {
        $authorizationParameters += @{ oauth_token = $OauthAccessToken }
    }

    $partiallySerializedAuthorizationParameters = $authorizationParameters.GetEnumerator() | Foreach-Object -Process {
        '{0}="{1}"' -f $_.Name, $_.Value
    }
    $serializedAuthorizationParameters = $partiallySerializedAuthorizationParameters -join ','
    $authorizationString = 'OAuth {0}' -f $serializedAuthorizationParameters

    Write-Verbose -Message ($LocalizedData.AuthorizationStringGeneratedMessage -f $authorizationString.Replace($escapedOauthSignature,[System.String]::new('*',20)))

    return $authorizationString
}
