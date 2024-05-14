<#
.DESCRIPTION
    This script downloads the TikTok video from the URL provided.

.PARAMETER Input
    string: The URL of the TikTok video.

.PARAMETER OutputFile
    Video file downloaded from the TikTok video.

.EXAMPLE
    ttu 'https://www.tiktok.com/@user/video/1234567890'

    Runs the script to download the TikTok video from the URL provided.
#>
function ttu {
  # Structure node .\src\app.js -param '<url>'
  param (
    [Parameter(Mandatory = $true)][string]$url
  )

  #First move to the project directory
  z 'V:\Developments\javascript-node\projects\tiktok-video-downloader'
  # Run javascript node application
  node .\src\app.js -u $url

  # Ask to show the files in the downloads folder
  $showFiles = $(Write-Host "Do you want to see the files in the downloads folder? (Y/N)" -ForegroundColor Yellow; Read-Host "Y/N")
  if ($showFiles -eq "Y") {
    # Open the downloads folder
    e .\downloads
  }
  else {
    # Write the message to the console
    Write-Host "Bye! Bye!" -ForegroundColor Green
  }
}