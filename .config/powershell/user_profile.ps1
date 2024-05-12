# Prompt
Import-Module posh-git
$omp_config = Join-Path $env:POSH_THEMES_PATH "\uew_loo-kuhs.omp.json"
oh-my-posh init pwsh --config $omp_config | Invoke-Expression

# Icons
Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Alias
Set-Alias e explorer
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias cc clear
Set-Alias to cd
Set-Alias grep findstr
Set-Alias open Invoke-Item
Set-Alias time Measure-Command
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Functions
function assoc { cmd /c assoc $args }
function ftype { cmd /c ftype $args }

function ttu {
  # Structure node .\src\app.js -param '<url>'
  param (
    [Parameter(Mandatory = $true)][string]$url
  )

  #First move to V: drive
  z 'V:\Developments\javascript-node\projects\tiktok-video-downloader'
  # Run javascript node application
  node .\src\app.js -u $url

  # Show the downloads folder
  e .\downloads

  # Write the message to the console
  Write-Host "Bye! Bye!"
}

# Function: (S)et (F)iles (b)y (E)xtension in the current directory
function Set-FilesByExtension {
  # improve the speed by creating the folders first, then moving the files in one command per each extension
  $extensions = Get-ChildItem -File | Select-Object -ExpandProperty Extension -Unique
  $extensions | ForEach-Object { mkdir $_.TrimStart('.') }
  $extensions | ForEach-Object { Move-Item *$_ $_.TrimStart('.') }
}

# Function: get the image resolution
function Get-ImageInfo {
  param (
    [Parameter(Mandatory = $true)][string]$path
  )

  $image = [System.Drawing.Image]::FromFile($path)
  $width = $image.Width
  $height = $image.Height
  $image.Dispose()

  [PSCustomObject]@{
    Width  = $width
    Height = $height
  }
}

# Funcion: Get File Size and information
function Get-FileInfo {
  param (
    [Parameter(Mandatory = $true)][string]$path
  )

  $file = Get-Item $path
  $size = $file.Length
  $size = [math]::Round($size / 1MB, 2)

  [PSCustomObject]@{
    Size = $size
  }
}

# Function: (S)et (I)mages (b)y (R)esolution in the current directory
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

# Function: (S)et (I)mages (b)y (H)eight in the current directory
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
      Write-Host "Error: $_"
    }
  }
  Write-Host "Total images moved: $($images.Count)"
}

# Function: (S)et (I)mages (b)y (S)ize in the current directory
function Set-ImagesBySize {
  $images = Get-ChildItem -File | Where-Object { $_.Extension -match 'jpg|jpeg|png|jfif|gif' }
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

# Function: Count the number of files by subdirectories and display by the count
function Get-TotalFiles {
  Get-ChildItem -Recurse -File | Group-Object Directory | Select-Object Name, Count  | Sort-Object Count -Descending

}

# Function: Move files in the subdirectories to the parent directory and remove empty subdirectories
function Move-FilesToParent {
  # Comprobe if the current directory is the root directory
  if ((Get-Location).Path -eq (Get-Location).Drive.Root) {
    Write-Host "The current directory is the root directory"
    return
  }
  # Comprobe if the subdirectories are not empty and move the files to the parent directory and delete the subdirectories
  Get-ChildItem -Recurse -File | Move-Item -Destination (Get-Location).Path
  Get-ChildItem -Recurse | Where-Object { $_.PSIsContainer -and ($_.GetFileSystemInfos().Count -eq 0) } | Remove-Item

  Write-Host "The files have been moved to the parent directory and the subdirectories have been removed"
}