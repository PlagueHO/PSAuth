<#
    .SYNOPSIS
        Generate a nonce for use with Oauth.

    .NOTES
        This function exists to make unit testing easier.
#>
function Get-PSAuthNonce
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param ()

    return [System.Guid]::NewGuid().Guid -replace '-'
}
