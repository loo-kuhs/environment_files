<#
.DESCRIPTION
    This script is used to avoid running scripts accidentally.

.PARAMETER InputFile
    N/A

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Set-SecurityToRunScript

    Runs the script to set the security to run scripts.
#>
function Set-SecurityToRunScript {
  param (
    [string]$scriptName
  )

  # Security check to avoid running scripts accidentally
  Write-Host "WARNING: This script will set the security to run scripts." -ForegroundColor Yellow
  Write-Host "Current directory: $(Get-Location)" -ForegroundColor Red
  $confirmation = Read-Host "Are you sure you want to continue? (Y/N)"

  if ($confirmation -eq 'Y') {
    $flag = $true

    # Return confirmation to run the script
    return $flag
  }
  else {
    Write-Host "Operation canceled" -ForegroundColor Yellow
    return
  }
  
}