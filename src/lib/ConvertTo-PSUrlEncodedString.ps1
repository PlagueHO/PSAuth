
<#
    .SYNOPSIS
        URL Encode a string using RFC 3986 standards.

    .PARAMETER String
        The string to URL encode.

    .NOTES
        This function is required because there is no standard
        library in .NET and .NET Core that URL encodes to RFC 3986.
#>
function ConvertTo-PSUrlEncodedString
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [System.String]
        $String
    )

    $doNotEncodeCharacters = [char[]]'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.~'
    $result = New-Object -Typename System.Text.StringBuilder

    foreach ($character in $String.ToCharArray())
    {
        if ($doNotEncodeCharacters -contains $character)
        {
            $null = $result.Append($character)
        }
        else
        {
            $null = $result.Append(('%{0:X2}' -f [System.Int32] $character))
        }
    }

    return $result.ToString()
}
