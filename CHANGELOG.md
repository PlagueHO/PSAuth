# Change Log

## Unreleased

- Change `psakefile.ps1` to detect Azure Pipelines correctly.
- Added PowerShell Gallery badge to `README.md`.
- Update URL Encoding to use more modern URL encoding method
  `[System.Web.Security.AntiXss.AntiXssEncoder]::UrlEncode()` - fixes
  [Issue #7](https://github.com/PlagueHO/PSAuth/issues/7).

## 0.1.2.36

- Fix bug in function `Invoke-PSAuthRestMethod` when passing `Headers` - fixes
  [Issue #4](https://github.com/PlagueHO/PSAuth/issues/4).

## 0.1.1.30

- Initial version.
