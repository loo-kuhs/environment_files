<#
.DESCRIPTION
    This script displays the total number of files in each directory in the current folder.

.PARAMETER InputFile
    N/A

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Get-TotalFiles

    Runs the script to display the total number of files in each directory in the current folder.
#>
function Get-TotalFiles {
  Get-ChildItem -Recurse -File | Group-Object Directory | Select-Object Name, Count  | Sort-Object Count -Descending | ForEach-Object {
    $directory = $_.Name
    $count = $_.Count
    $totalSize = (Get-ChildItem -Recurse -File $directory | Measure-Object -Property Length -Sum).Sum / 1MB
    $shortName = $directory -replace '.*\\'
    $relativePath = Resolve-Path -Path $directory -Relative
    
    # Format the output as table
    [PSCustomObject]@{
      Folder    = $shortName
      Size_MB = [Math]::Round($totalSize, 2)
      Files     = $count 
      Directory = $relativePath
    }
  }
}