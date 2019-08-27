@{

    # Script module or binary module file associated with this manifest.
    RootModule           = 'PSAuth.psm1'

    # Version number of this module.
    ModuleVersion        = '0.1.4.51'

    # Supported PSEditions
    CompatiblePSEditions = 'Core', 'Desktop'

    # ID used to uniquely identify this module
    GUID                 = 'dfb432ec-1221-4b20-a417-ba4cb63ff97f'

    # Author of this module
    Author               = 'Daniel Scott-Raynsford'

    # Company or vendor of this module
    CompanyName          = 'None'

    # Copyright statement for this module
    Copyright            = '(c) Daniel Scott-Raynsford. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'PowerShell module containing functions to make HTTP requests including OAuth 1.0 authentication.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion    = '5.1'

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport    = @(
        'Get-PSAuthorizationString'
        'Invoke-PSAuthRestMethod'
    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport      = @()

    # Variables to export from this module
    VariablesToExport    = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport      = @()

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{

        PSData = @{
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @('OAuth', 'Authorization')

            # A URL to the license for this module.
            LicenseUri   = 'https://github.com/PlagueHO/PSAuth/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/PlagueHO/PSAuth'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            ReleaseNotes = '
## What is New in PSAuth 0.1.4.78

August 27, 2019

- Updated Azure Pipelines CI to use multi-stage pipeline to include publish step.
- Fix error in `Get-PSAuthorizationString` when URI contains Query String
    parameters - fixes [Issue #14](https://github.com/PlagueHO/PSAuth/issues/14).
- Added `OutFile` parameter to `Invoke-PSAuthRestMethod`.

## What is New in PSAuth 0.1.3.51

August 09, 2019

- Change `psakefile.ps1` to detect Azure Pipelines correctly.
- Added PowerShell Gallery badge to `README.md`.
- Update URL Encoding to use URL encoding method that is RFC 3986 compliant - fixes
  [Issue #7](https://github.com/PlagueHO/PSAuth/issues/7).
- Change `Get-PSAuthorizationString` to URL encode signature values using RFC 3968.

## What is New in PSAuth 0.1.2.36

August 06, 2019

- Fix bug in function `Invoke-PSAuthRestMethod` when passing `Headers` - fixes
    [Issue #4](https://github.com/PlagueHO/PSAuth/issues/4).

## What is New in PSAuth 0.1.1.30

May 24, 2019

- Initial Version.
  '

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
}
