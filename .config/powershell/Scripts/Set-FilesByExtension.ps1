<#
.DESCRIPTION
    This script moves files in the current directory to folders based on their extension.

.PARAMETER InputFile
    N/A

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Set-FilesByExtension

    Runs the script to move files in the current directory to folders based on their extension.
#>
function Set-FilesByExtension {
  $extensions = Get-ChildItem -File | Select-Object -ExpandProperty Extension -Unique
  # $extensions | ForEach-Object { mkdir $_.TrimStart('.') }
  # $extensions | ForEach-Object { Move-Item *$_ $_.TrimStart('.') }
  try {
    $extensions | ForEach-Object {
      $extension = $_
      $folder = $extension.TrimStart('.').ToUpper()
      if (-not (Test-Path $folder)) {
        mkdir $folder
      }
      Move-Item *$extension $folder

    }
  }
  catch {
    Write-Host "Error: $_"
  }

  Write-Host "Files moved"
}
