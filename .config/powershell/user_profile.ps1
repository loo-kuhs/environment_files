# Prompt
Import-Module posh-git
$omp_config = Join-Path $env:POSH_THEMES_PATH "\uew_loo-kuhs.omp.json"
oh-my-posh init pwsh --config $omp_config | Invoke-Expression

# Icons
Import-Module -Name Terminal-Icons

# Import my custom functions
  # Primary functions
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Get-FileInfo.ps1
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Get-ImageInfo.ps1
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Get-VideoInfo.ps1
  # Secondary functions
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Get-TotalFiles.ps1
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Set-ImagesBySize.ps1
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Move-FilesToParent.ps1
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Set-ImagesByHeight.ps1
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Set-VideosByLength.ps1
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Set-FilesByExtension.ps1
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Set-FilesByInputName.ps1
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Set-ImagesByResolution.ps1
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Rename-FilesSequentially.ps1
# Miscellaneous functions
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Get-TikTokVideo.ps1
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Search-InHistory.ps1
Import-Module -Name $env:USERPROFILE\.config\powershell\Scripts\Set-MyFilesByFolderName.ps1

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
