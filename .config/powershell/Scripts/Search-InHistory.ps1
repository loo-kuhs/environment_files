<#
.DESCRIPTION
    This script receives an input string and search in the powershell command history.

.PARAMETER textInputFile
    string: the input string to search in the powershell command history.

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Search-InHistory -textInput 'ffmpeg'

    Search for the input string 'ffmpeg' in the powershell command history, and returns the results.
#>
function Search-InHistory {
  param (
    [Parameter(Mandatory = $true)][string]$textInput
  )

  Write-Host "Input: $($textInput)" -ForegroundColor Red

  $results = Get-Content (Get-PSReadLineOption).HistorySavePath | Where-Object { $_ -like "*$textInput*" }

  if ($results.Count -eq 0) {
    Write-Host "No results found with the input string: $textInput" -ForegroundColor Yellow
    return
  }
  # Copy the results to the clipboard
  $results | Set-Clipboard
  
  # Display the results
  $results | ForEach-Object {
    Write-Host $_ -ForegroundColor White
  }

  Write-Host "Total results found: $($results.Count)" -ForegroundColor Yellow
}