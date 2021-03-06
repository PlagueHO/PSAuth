# Change Log

## 0.1.4.78

- Updated Azure Pipelines CI to use multi-stage pipeline to include publish step.
- Fix error in `Get-PSAuthorizationString` when URI contains Query String
  parameters - fixes [Issue #14](https://github.com/PlagueHO/PSAuth/issues/14).
- Added `OutFile` parameter to `Invoke-PSAuthRestMethod`.

## 0.1.3.51

- Change `psakefile.ps1` to detect Azure Pipelines correctly.
- Added PowerShell Gallery badge to `README.md`.
- Update URL Encoding to use URL encoding method that is RFC 3986 compliant - fixes
  [Issue #7](https://github.com/PlagueHO/PSAuth/issues/7).
- Change `Get-PSAuthorizationString` to URL encode signature values using RFC 3968.

## 0.1.2.36

- Fix bug in function `Invoke-PSAuthRestMethod` when passing `Headers` - fixes
  [Issue #4](https://github.com/PlagueHO/PSAuth/issues/4).

## 0.1.1.30

- Initial version.
