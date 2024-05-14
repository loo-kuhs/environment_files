<#
.DESCRIPTION
    This script moves images to folders based on their resolution.

.PARAMETER InputFile
    N/A

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Set-ImagesByResolution

    Runs the script to move images to folders based on their resolution.
#>
function Set-ImagesByResolution {
  $images = Get-ChildItem -File | Where-Object { $_.Extension -match 'jpg|jpeg|png|jfif|gif' }
  $images | ForEach-Object {
    try {
      $image = $_
      $imageInfo = Get-ImageInfo $image.FullName
      $folder = "$($imageInfo.Width)x$($imageInfo.Height)"
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