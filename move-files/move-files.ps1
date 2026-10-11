param(
    [String]$sourcePath = $(throw "sourcePath parameter is required."),
    [String]$destinationPath = $(throw "destinationPath pramaeter is required.")
)

function Move-Files {
    # Test network path
    param (
        [String]$sourcePath,
        [String]$destinationPath
    )

    $sourceExists = Test-Path $sourcePath -PathType "Container"
    if (-Not $sourceExists) {
        throw "Failed to find Source path, ensure the sourcePath parameter is a valid directory."
    }

    $destinationExists = Test-Path $destinationPath -PathType "Container"
    if (-Not $destinationExists) {
        throw "Failed to find Destination path, ensure the destinationPath parameter is a valid directory."
    }

    $source = Get-Item -Path $sourcePath

    # Calculate the date of the oldest file to keep, in this case right now minus one year.
    $targetDate = (Get-Date).AddYears(-1)

    # initialize loop variables
    [String[]]$filesMoved = @()
    [String]$moveDestinationPath = ''

    Write-Output "Looping through subsdirectors of $sourcePath."
    foreach ($subdirectory in Get-ChildItem -Path $sourcePath -Directory -Recurse) {
        # Check all files in $subdirectory. If older than $targetDate, move the file and leave the new path in a file inside the directory
        # Get-ChildItem can be passed `-Filter *.jpg` to limit by filename as well.
        Get-ChildItem -Path $subdirectory -File |
            Where-Object CreationTime -GT $targetDate |
            ForEach-Object -Begin {
                # these commands run once per directory before the -Process block below
                $filesMoved = @() # Re-initialize files list for current directory
                Write-Output "Processing $($subdirectory.FullName)."

                # Get the portion of the path after the sourcePath. Add one because substring is zero-based
                $relativePath = $subdirectory.FullName.substring($source.FullName.Length)
                $moveDestinationPath = Join-Path $destinationPath $relativePath

                # Ensure destination directory exists, create it if not.
                if (-Not (Test-Path -Path $moveDestinationPath)) {
                    New-Item -Path $moveDestinationPath -ItemType "Directory" | Out-Null
                }

                # Update $moveDestinationPath with the resolved location, so that relative paths are handled.
                $moveDestinationPath = Join-Path $destinationPath $relativePath -Resolve
            } -Process {
                # These commands are run on each file
                $filesMoved += $_.Name
                Move-Item -Path $($_.FullName) -Destination $moveDestinationPath
            } -End {
                # these commands run once per directory, after the -Process block above
                $pointerFile = Join-Path $subdirectory "moved-files.txt"

                # For each file in $filesMoved, add a line to $pointerFile that says where the file moved to
                $filesMoved | ForEach-Object { Add-Content $pointerFile -Value "$_ -> $(Join-Path $moveDestinationPath $_)" }
                Write-Output "Finished processing $($source.FullName). Moved $($filesMoved.Length) file(s)."
            }
    }
}

Move-Files $sourcePath $destinationPath