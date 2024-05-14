<#
.DESCRIPTION
    This script moves images to folders based on their size.

.PARAMETER InputFile
    N/A

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Set-ImagesBySize

    Runs the script to move images to folders based on their size.
#>
function Set-ImagesBySize {
  $images = Get-ChildItem -File | Where-Object { $_.Extension -match 'jpg|jpeg|png|jfif|gif|mp4|webm' }
  $images | ForEach-Object {
    try {
      $image = $_
      $imageInfo = Get-FileInfo $image.FullName
      $folder = "$($imageInfo.Size)MB"
      if (-not (Test-Path $folder)) {
        mkdir $folder
      }
      Move-Item $image.FullName $folder
    }
    catch {
      Write-Host "Error: $_"
    }
  }
  Write-Host "Total images moved: $($images.Count)"
}