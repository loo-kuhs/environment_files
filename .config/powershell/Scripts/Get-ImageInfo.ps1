<#
.DESCRIPTION
    This script gets the width and height of an image file.

.PARAMETER InputFile
    string: The path to the image file.

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Get-ImageInfo -path 'C:\Users\user\Downloads\image.jpg'

    Gets the width and height of the image file.
#>
function Get-ImageInfo {
  param (
    [Parameter(Mandatory = $true)][string]$path
  )
  try {
    $stream = New-Object System.IO.FileStream($path, [System.IO.FileMode]::Open)
    $image = [System.Drawing.Image]::FromStream($stream)
    $width = $image.Width
    $height = $image.Height
    $created = (Get-Item $path).CreationTime

    [PSCustomObject]@{
      Width  = $width
      Height = $height
      CreatedAt = $created
    }
  }
  catch {
    Write-Host "Error: $($_.Exception.Message), Path: $($path)" -ForegroundColor Red
  }
  finally {
    $stream.Close()
    $stream.Dispose()
  }
}
