<#
.DESCRIPTION
    This script receives a textInput string and searches for files with start with the textInput string. 
    And moves the files to a folder with the same name as the textInput string.

.PARAMETER textInputFile
    string: The path to the file.

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Set-FilesBytextInputName -textInput 'photos_vacation'

    Moves files that start with 'photos_vacation' to a folder with the same name.
#>
function Set-FilesByInputName {
  param (
    [Parameter(Mandatory = $true)][string]$textInput
  )

  Write-Host "Input: $($textInput)" -ForegroundColor Cyan

  $files = Get-ChildItem -File -Filter "$textInput*"
  
  if ($files.Count -eq 0) {
    Write-Host "[0] No files found with the input string: $textInput" -ForegroundColor Red
    return
  } 

  $folder = "$textInput"
  if (-not (Test-Path $folder)) {
    mkdir $folder
  }

  $files | ForEach-Object {
    try {
      $file = $_
      Move-Item $file.FullName $folder
      Write-Host "[>] File " -ForegroundColor Cyan -NoNewline 
      Write-Host $($file.Name) -ForegroundColor DarkMagenta -NoNewline
      Write-Host " moved to folder -> " -ForegroundColor Cyan -NoNewline
      Write-Host $($folder) -ForegroundColor DarkMagenta
    }
    catch {
      Write-Host "Error: $_" -ForegroundColor Red
    }
  }

  Write-Host "[+] Total files moved: $($files.Count)" -ForegroundColor Green
}