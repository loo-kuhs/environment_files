<#
.DESCRIPTION
    This script moves files in the subdirectories to the parent directory and removes empty subdirectories.
    And creates a log with the full path of the files to move.

.PARAMETER InputFile
    N/A

.PARAMETER OutputFile
    N/A

.EXAMPLE
    Move-FilesToParent

    Runs the script to move files in the subdirectories to the parent directory and removes empty subdirectories.
#>
function Move-FilesToParent {
    # Security check to avoid moving files in the root directory, ask for confirmation
    Write-Host "WARNING: This script will move files in the subdirectories to the parent directory and remove empty subdirectories." -ForegroundColor Yellow
    Write-Host "Current directory: $(Get-Location)" -ForegroundColor Red
    $confirmation = Read-Host "Are you sure you want to continue? (Y/N)"

    if ($confirmation -eq 'Y') {
        # Comprobe if the subdirectories are not empty and move the files to the parent directory and delete the subdirectories

        try {
            # Create log with the full path of the files to move
            Get-ChildItem -Recurse -File | Select-Object -ExpandProperty FullName | Out-File -FilePath "__FilesToMove.txt"
            Write-Host "The files to move have been saved in the file '__FilesToMove.txt'" -ForegroundColor Green

            # Move the files to the parent directory
            Get-ChildItem -Recurse -File | Move-Item -Destination (Get-Location).Path
            Get-ChildItem -Recurse | Where-Object { $_.PSIsContainer -and ($_.GetFileSystemInfos().Count -eq 0) } | Remove-Item
        
            
            
            Write-Host "The files have been moved to the parent directory and the subdirectories have been removed" -ForegroundColor Green
    
        }
        catch {
            Write-Host "Error: $($_.Exception.Message), Path: $(Get-Location)" -ForegroundColor Red
        }
    }
    else {
        Write-Host "Operation canceled" -ForegroundColor Yellow
        return
    }

}