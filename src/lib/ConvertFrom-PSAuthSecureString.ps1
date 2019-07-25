<#
    .SYNOPSIS
        Convert a SecureString back to a string.

    .PARAMETER SecureString
        The SecureString to convert back to a string.
#>
function ConvertFrom-PSAuthSecureString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Security.SecureString]
        $SecureString
    )

    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
    return [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
}
