<#
    .SYNOPSIS
        Generate a time stamp for use with Oauth.

    .NOTES
        This function exists to make unit testing easier.
#>
function Get-PSAuthTimestamp
{
    [CmdletBinding()]
    [OutputType([System.Int32])]
    param ()

    return [System.Int32] ((Get-Date).ToUniversalTime() - (Get-Date -Date '1/1/1970')).TotalSeconds
}
