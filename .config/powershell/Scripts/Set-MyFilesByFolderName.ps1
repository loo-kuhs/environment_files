<#
.DESCRIPTION
    This script orders the files by the folders name in the current directory.

.PARAMETER InputFile
    N/A

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Set-MyFilesByFolderName

    Orders the files by the folders name in the current directory.
#>
function Set-MyFilesByFolderName {
  $files = Get-ChildItem -File
  $folders = Get-ChildItem -Directory

  foreach ($folder in $folders) {
    $folderName = $folder.Name
    $folderFiles = $files | Where-Object { $_.Name -match "$folderName*" }

    if ($folderFiles.Count -eq 0) {
      Write-Host "[0] No matches for the folder -> $folderName" -ForegroundColor Red
      continue
    }

    if (-not (Test-Path $folderName)) {
      mkdir $folderName
    }

    $folderFiles | ForEach-Object {
      try {
        $file = $_
        Move-Item $file.FullName $folderName
        Write-Host "[>] File " -ForegroundColor Cyan -NoNewline 
        Write-Host $($file.Name) -ForegroundColor DarkMagenta -NoNewline
        Write-Host " moved to folder -> " -ForegroundColor Cyan -NoNewline
        Write-Host $($folderName) -ForegroundColor DarkMagenta
      }
      catch {
        Write-Host "Error: $_" -ForegroundColor Red
      }
    }
    Write-Host "[+] Total files moved to folder $($folderName): $($folderFiles.Count)" -ForegroundColor Green
  }
}
