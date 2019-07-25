---
external help file: PSAuth-help.xml
Module Name: PSAuth
online version:
schema: 2.0.0
---

# Invoke-PSAuthRestMethod

## SYNOPSIS

Execute Invoke-RestMethod including an OAuth 1.0 authorization
header.

## SYNTAX

```powershell
Invoke-PSAuthRestMethod [-Uri] <Uri> [-OauthConsumerKey] <String>
 [-OauthConsumerSecret] <SecureString> [[-OauthAccessToken] <String>]
 [[-OauthAccessTokenSecret] <SecureString>] [[-OauthSignatureMethod] <String>]
 [[-OauthVersion] <String>] [[-OauthParameters] <Hashtable>] [[-Method] <String>]
 [[-ContentType] <String>] [[-Headers] <System.Collections.IDictionary>]
 [[-Body] <String>] [[-Proxy] <String>] [[-ProxyCredential] <PSCredential>]
 [-ProxyUseDefaultCredentials] [-DisableKeepAlive] [<CommonParameters>]
```

## DESCRIPTION

{{ Fill in the Description }}

## EXAMPLES

### Example 1

```powershell
PS C:\> Invoke-PSAuthRestMethod -Uri 'https://contoso.com/oauth2/api/get' `
    -OauthConsumerKey 'MyConsumerKey' `
    -OauthConsumerSecret (ConvertTo-SecureString -String 'MySecret' -AsPlainTextForce) `
    -Method 'Get'
```

Execute Invoke-RestMethod adding an Authorization header containing an OAuth 1.0
signature.

## PARAMETERS

### -Body

Specifies the body of the request.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentType

Specifies the content type of the web request.

If this parameter is omitted and the request method is POST,
Invoke-PSAuthRestMethod sets the content type to application/x-www-form-urlencoded.
Otherwise, the content type is not specified in the call.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableKeepAlive

Indicates that the cmdlet sets the KeepAlive value in the HTTP header to False.
By default, KeepAlive is True.
KeepAlive establishes a persistent connection
to the server to facilitate subsequent requests.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Headers

Specifies the headers of the web request. Enter a hash table or dictionary.

```yaml
Type: System.Collections.IDictionary
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Method

Specifies the method used for the web request.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: Get
Accept pipeline input: False
Accept wildcard characters: False
```

### -OauthAccessToken

The OAuth access token to use for the signature.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OauthAccessTokenSecret

The OAuth access token secret to use for the signature.

```yaml
Type: System.Security.SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OauthConsumerKey

The OAuth consumer key to use for the signature.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OauthConsumerSecret

The OAuth consumer secret to use for the signature.

```yaml
Type: System.Security.SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OauthParameters

Any additional parameters to include in the OAuth signature.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -OauthSignatureMethod

The OAuth signature hash method to use.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: HMAC-SHA1
Accept pipeline input: False
Accept wildcard characters: False
```

### -OauthVersion

The OAuth signature version to use.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 1.0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Proxy

Specifies that the cmdlet uses a proxy server for the request, rather
than connecting directly to the Internet resource.
Enter the URI of
a network proxy server.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyCredential

Specifies a user account that has permission to use the proxy server
that is specified by the Proxy parameter.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a
PSCredential object, such as one generated by the Get-Credential cmdlet.

This parameter is valid only when the Proxy parameter is also used
in the command.
You cannot use the ProxyCredential and
ProxyUseDefaultCredentials parameters in the same command.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyUseDefaultCredentials

Indicates that the cmdlet uses the credentials of the current user to access
the proxy server that is specified by the Proxy parameter.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri

Specifies the Uniform Resource Identifier (URI) of the Internet resource
to which the web request is sent.

```yaml
Type: System.Uri
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS
