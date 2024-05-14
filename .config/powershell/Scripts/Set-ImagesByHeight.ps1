<#
.DESCRIPTION
    This script moves images to folders based on their height.

.PARAMETER InputFile
    N/A

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Set-ImagesByHeight

    Runs the script to move images to folders based on their height.
#>
function Set-ImagesByHeight {
  $images = Get-ChildItem -File | Where-Object { $_.Extension -match 'jpg|jpeg|png|jfif|gif' }
  $images | ForEach-Object {
    try {
      $image = $_
      $imageInfo = Get-ImageInfo $image.FullName
      $folder = "$($imageInfo.Height)_HEIGHT"
      if (-not (Test-Path $folder)) {
        mkdir $folder
      }
      Move-Item $image.FullName $folder     
    }
    catch {
      Write-Host "Error: $_" -ForegroundColor Red
    }
  }
  Write-Host "Total images moved: $($images.Count)" -ForegroundColor Green
}
