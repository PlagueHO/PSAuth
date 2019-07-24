<#
    .SYNOPSIS
        Enables PowerShell support of TLS1.2.

    .OUTPUTS
        None
#>
function Set-PSAuthTlsSupport
{
    [CmdLetBinding()]
    param ()

    if (-not ([Net.ServicePointManager]::SecurityProtocol).ToString().Contains([Net.SecurityProtocolType]::Tls12))
    {
        [Net.ServicePointManager]::SecurityProtocol = `
            [Net.ServicePointManager]::SecurityProtocol.toString() + ', ' + [Net.SecurityProtocolType]::Tls12
    }
}
