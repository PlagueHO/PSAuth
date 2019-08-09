# Release Notes

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
