<#
.DESCRIPTION
    This scrips is used to obtain information about videos files.

.PARAMETER InputFile
    N/A

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Get-VideoInfo

    Runs the script to obtain information about video files.
#>
function Get-VideoInfo {
  param (
    [Parameter(Mandatory = $true)][string]$path
  )
  $Shell = New-Object -ComObject Shell.Application
  $Folder = $Shell.Namespace((Get-Item $path).DirectoryName)
  try {
    $File = $Folder.ParseName((Get-Item $path).Name)
    $duration = $Folder.GetDetailsOf($File, 27) # Duration in format hh:mm:ss
    # Set the duration in seconds
    $parsedDuration = [timespan]::Parse($duration).TotalMilliseconds
    $calculateSeconds = [math]::Round($parsedDuration / 1000)
    $parseToString = $calculateSeconds.ToString()

    [PSCustomObject]@{
      Duration = $parseToString
    }
  }
  catch {
    Write-Host "Error: $($_.Exception.Message), Path: $($path)" -ForegroundColor Red
  }
}