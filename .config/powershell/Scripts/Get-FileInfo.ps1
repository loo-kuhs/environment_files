<#
.DESCRIPTION
    This script gets the size of a file.

.PARAMETER InputFile
    string: The path to the file.

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Get-FileInfo -path 'C:\Users\user\Downloads\image.jpg'

    Gets the size of the file.
#>
function Get-FileInfo {
  param (
    [Parameter(Mandatory = $true)][string]$path
  )
  try {
    $file = Get-Item $path
    $size = $file.Length
    $size = [math]::Round($size / 1MB, 2)
    $created = $file.CreationTime
  
    [PSCustomObject]@{
      Size      = $size
      CreatedAt = $created
    }
  }
  catch {
    Write-Host "Error: $($_.Exception.Message), Path: $($path)" -ForegroundColor Red
  }
}
