<#
    .SYNOPSIS
        Deserialize a string into a hashtable.

    .PARAMETER String
        The string to convert.

    .PARAMETER PairSeparator
        The string separating each set of key=value pairs.

    .PARAMETER KeyValueSeparator
        The string separating the keys from the values.

    .OUTPUTS
        The hashtable created from reading the string.
 #>
function Convert-PSAuthStringToHashTable
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(ValueFromPipeline = $true, Position = 0, Mandatory = $true)]
        [System.String]
        $String,

        [Parameter(Position = 1)]
        [System.String]
        $PairSeparator = '&',

        [Parameter(Position = 2)]
        [System.String]
        $KeyValueSeparator = '='
    )

    process
    {
        $hashtable = @{ }

        foreach ($item in $QueryString.split($pairSeparator) )
        {
            $key, $value = $item.split($KeyValueSeparator, 2)
            $hashtable.Add($key, $vvalue)
        }

        return $hashtable
    }
}
