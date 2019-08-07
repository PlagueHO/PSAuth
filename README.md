[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/PlagueHO/PSAuth/blob/dev/LICENSE)
[![Documentation - PSAuth](https://img.shields.io/badge/Documentation-PSAuth-blue.svg)](https://github.com/PlagueHO/PSAuth/wiki)
[![PowerShell Gallery - PSAuth](https://img.shields.io/badge/PowerShell%20Gallery-PSAuth-blue.svg)](https://www.powershellgallery.com/packages/PSAuth)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/psauth.svg)](https://www.powershellgallery.com/packages/PSAuth)
[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-5.1-blue.svg)](https://github.com/PlagueHO/PSAuth)
[![Minimum Supported PowerShell Core Version](https://img.shields.io/badge/PowerShell_Core-6.0-blue.svg)](https://github.com/PlagueHO/PSAuth)
[![Wiki](https://img.shields.io/badge/Wiki-yellow.svg)](https://github.com/PlagueHO/PSAuth/Wiki)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/1b088fb1093947fca0b1070c8b09055b)](https://app.codacy.com/app/PlagueHO/PSAuth?utm_source=github.com&utm_medium=referral&utm_content=PlagueHO/PSAuth&utm_campaign=Badge_Grade_Dashboard)

# PSAuth

PowerShell module containing functions to make HTTP requests including
OAuth 1.0 authentication.

## Module Build Status

| Branch | AzurePipelines CI | AppVeyor CI | Travis CI | Code Coverage |
| --- | --- | --- | --- | --- |
| dev | [![ap-image-dev][]][ap-site-dev] | [![av-image-dev][]][av-site-dev] | [![tv-image-dev][]][tv-site-dev] | [![cc-image-dev][]][cc-site-dev] |
| master | [![ap-image-master][]][ap-site-master] | [![av-image-master][]][av-site-master] | [![tv-image-master][]][tv-site-master] | [![cc-image-master][]][cc-site-master] |

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Compatibility and Testing](#compatibility-and-testing)
- [Automated Integration Tests](#automated-integration-tests)
- [Cmdlets](#cmdlets)
- [Known Issues](#known-issues)
- [Recommendations](#recommendations)
- [Examples](#examples)
- [Links](#links)

## Requirements

This module requires the following:

- Windows PowerShell 5.1 and above or
- PowerShell Core 6.x on:
  - Windows
  - Linux
  - macOS

## Installation

> If Windows Management Framework 5.1 or above is installed or the PowerShell
> Package management module is available:

The easiest way to download and install the PSAuth module is using PowerShell
Get to download it from the PowerShell Gallery:

```powershell
Install-Module -Name PSAuth
```

> If Windows Management Framework 5.1 or above is not available and the
> PowerShell Package management module is not available:

Unzip the file containing this Module to your `c:\Program Files\WindowsPowerShell\Modules`
folder.

## Compatibility and Testing

This PowerShell module is automatically tested and validated to run
on the following systems:

- Windows Server (using Windows PowerShell 5.1):
  - Windows Server 2012 R2: Using [AppVeyor CI](https://ci.appveyor.com/project/PlagueHO/PSAuth).
  - Windows Server 2016: Using [AppVeyor CI](https://ci.appveyor.com/project/PlagueHO/PSAuth).
- Linux (using PowerShell Core 6.x):
  - Ubuntu Trusty 14.04: Using [Tavis CI](https://travis-ci.org/PlagueHO/PSAuth).
- macOS (using PowerShell Core 6.x):
  - macOS 10.13: Using [Tavis CI](https://travis-ci.org/PlagueHO/PSAuth).

This module should function correctly on other systems and configurations
but is not automatically tested with them in every change.

### Automated Integration Tests

This project does not currently contain any automated integration tests.

## Cmdlets

- `Get-PSAuthorizationString`: Create an OAuth 1.0 Authorization string for use in
  an HTTP request.
- `Invoke-PSAuthRestMethod`: Execute Invoke-RestMethod including an OAuth 1.0
  authorization header.

The full details of the cmdlets contained in this module can also be
found in the [wiki](https://github.com/PlagueHO/PSAuth/wiki).

## Known Issues

None.

## Recommendations

None.

## Examples

For further examples, please see module help for individual cmdlets.

## Links

- [GitHub Repository](https://github.com/PlagueHO/PSAuth/)
- [Blog](http://dscottraynsford.com/)

[ap-image-dev]: https://dev.azure.com/dscottraynsford/GitHub/_apis/build/status/PlagueHO.PSAuth?branchName=dev
[ap-site-dev]: https://dev.azure.com/dscottraynsford/GitHub/_build/latest?definitionId=13
[av-image-dev]: https://ci.appveyor.com/api/projects/status/1qr3ugd0i1adnv1s/branch/dev?svg=true
[av-site-dev]: https://ci.appveyor.com/project/PlagueHO/PSAuth/branch/dev
[tv-image-dev]: https://travis-ci.org/PlagueHO/PSAuth.svg?branch=dev
[tv-site-dev]: https://travis-ci.org/PlagueHO/PSAuth/branches
[cc-image-dev]: https://codecov.io/gh/PlagueHO/PSAuth/branch/dev/graph/badge.svg
[cc-site-dev]: https://codecov.io/gh/PlagueHO/PSAuth/branch/dev

[ap-image-master]: https://dev.azure.com/dscottraynsford/GitHub/_apis/build/status/PlagueHO.PSAuth?branchName=master
[ap-site-master]: https://dev.azure.com/dscottraynsford/GitHub/_build/latest?definitionId=13
[av-image-master]: https://ci.appveyor.com/api/projects/status/1qr3ugd0i1adnv1s/branch/master?svg=true
[av-site-master]: https://ci.appveyor.com/project/PlagueHO/PSAuth/branch/master
[tv-image-master]: https://travis-ci.org/PlagueHO/PSAuth.svg?branch=master
[tv-site-master]: https://travis-ci.org/PlagueHO/PSAuth/branches
[cc-image-master]: https://codecov.io/gh/PlagueHO/PSAuth/branch/master/graph/badge.svg
[cc-site-master]: https://codecov.io/gh/PlagueHO/PSAuth/branch/master
