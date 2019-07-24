<#
    .SYNOPSIS
        Convert a hash table into a string.

    .DESCRIPTION
        Converts a hash table into a string by joining the keys to the
        values, and then joining all the pairs together.

        The hash table can be optionally sorted by a combination of key and
        value before being converted.

    .PARAMETER HashTable
        The hash table to convert.

    .PARAMETER PairSeparator
        The string used to concatenate the sets of key=value pairs.

    .PARAMETER KeyValueSeparator
        The string used to concatenate the keys to the values.

    .PARAMETER KeyValueSeparator
        An array of properties to sort by, may only be a combination of
        'Name','Value'.

    .OUTPUTS
        The query string created by joining keys to values and then
        joining them all together into a single string.
#>
function Convert-PSAuthHashTableToString
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]
        $HashTable,

        [Parameter()]
        [System.String]
        $PairSeparator = '&',

        [Parameter()]
        [System.String]
        $KeyValueSeparator = '=',

        [Parameter()]
        [System.String[]]
        $Sort
    )

    [System.String]::Join($PairSeparator, @(
            $enumerator = $HashTable.GetEnumerator()

            if ($PSBoundParameters.ContainsKey('Sort'))
            {
                $enumerator = $enumerator | Sort-Object -Property $Sort
            }

            foreach ($item in $enumerator)
            {
                if ($item.Name)
                {
                    '{0}{1}{2}' -f $item.Name, $KeyValueSeparator, $item.Value
                }
            }
        ))
}
