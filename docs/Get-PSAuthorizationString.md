---
external help file: PSAuth-help.xml
Module Name: PSAuth
online version:
schema: 2.0.0
---

# Get-PSAuthorizationString

## SYNOPSIS

Create an OAuth 1.0 Authorization string for use in an
HTTP request.

## SYNTAX

```powershell
Get-PSAuthorizationString [-Uri] <Uri> [-OauthConsumerKey] <String>
 [-OauthConsumerSecret] <SecureString> [[-OauthAccessToken] <String>]
 [[-OauthAccessTokenSecret] <SecureString>] [[-OauthSignatureMethod] <String>]
 [[-OauthVersion] <String>] [[-OauthParameters] <Hashtable>] [[-Method] <String>]
 [<CommonParameters>]
```

## DESCRIPTION

{{ Fill in the Description }}

## EXAMPLES

### Example 1

```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

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
Default value: @{ }
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
