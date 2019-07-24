<#
    .SYNOPSIS
        Normalize a URI for use in an Oauth signature.

    .DESCRIPTION
        Normalize a URI by converting the hostname into all lower case
        and ensure port is included if not HTTP/HTTPS.

    .PARAMETER Uri
        The URI to normalize.
#>
function Get-PSAuthNormalizedUri
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Uri]
        $Uri
    )

    $normalizedUri = ('{0}://{1}' -f $Uri.Scheme, $Uri.Host).ToLower()

    if (-not (($Uri.Scheme -eq 'http' -and $Uri.Port -eq 80) `
                -or ($Uri.Scheme -eq 'https' -and $Uri.Port -eq 443)))
    {
        $normalizedUri += ':' + $Uri.Port
    }

    $normalizedUri += $Uri.AbsolutePath

    return $normalizedUri
}
