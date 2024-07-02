<#
.DESCRIPTION
    This script moves videos to folders based on their length (duration).

.PARAMETER InputFile
    N/A

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Set-VideosByLength

    Runs the script to move videos to folders based on their length.
#>
function Set-VideosByLength {
  $videos = Get-ChildItem -File | Where-Object { $_.Extension -match 'mp4|m4v|mov' }
  $videos | ForEach-Object {
    try {
      $video = $_
      $videoInfo = Get-VideoInfo $video.FullName
      $folder = "$($videoInfo.Duration)_seconds"
      if (-not (Test-Path $folder)) {
        mkdir $folder
      }
      Move-Item $video.FullName $folder
    }
    catch {
      Write-Host "Error: $_" -ForegroundColor Red
    }
  }
}