<#
.DESCRIPTION
    This script is used to rename files sequentially in a folder.
    e.g: 001.jpg, 002.jpg, 003.jpg, 004.jpg, 005.jpg, etc.

.PARAMETER InputFile
    N/A

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Rename-FilesSequentially

    Runs the script to rename files sequentially in a folder.

.TODO
    - Add log file with the old and new names of the files.
#>
function Rename-FilesSequentially {
  # Security check to avoid moving files in the root directory, ask for confirmation
  Write-Host "WARNING: This script will rename files sequentially in the current directory." -ForegroundColor Yellow
  Write-Host "Current directory: $(Get-Location)" -ForegroundColor Red
  $confirmation = Read-Host "Are you sure you want to continue? (Y/N)"

  if ($confirmation -eq 'Y') {
    # Ask for the start number
    $enterStartNumber = Read-Host "Enter the start number (default is 1):"
    if ($enterStartNumber -ne '') {
      $i = [int]$enterStartNumber
    }
    else {
      $i = 1
    }

    try {
      $files = Get-ChildItem -File
      $files | ForEach-Object {
        try {
          $file = $_
          $extension = $file.Extension
          $newName = "{0:D5}{1}" -f $i, $extension
          Rename-Item $file.FullName $newName
          $i++
        }
        catch {
          Write-Host "Error: $_" -ForegroundColor Red
        }
      }
    }
    catch {
      Write-Host "Error: $($_.Exception.Message), Path: $(Get-Location)" -ForegroundColor Red
    }
  }
  else {
    Write-Host "Operation canceled" -ForegroundColor Yellow
    return
  }
}