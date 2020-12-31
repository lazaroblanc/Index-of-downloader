<##Requires -PSEdition Desktop#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic

# Prompt for Url
$title = '"Index of" downloader'
$msg = @"
EN: Please enter URL

DE: Bitte URL eingeben
"@

$Url = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title, "https://...")

if ($Url.length -eq 0) {
    exit
}

if (-not [Uri]::IsWellFormedUriString($Url, 1)) {
    "Malformed Url" | Write-Error
    exit
}

# Prompt for download location
$folderBrowseDialog = [System.Windows.Forms.FolderBrowserDialog]::new()
$folderBrowseDialog.Description = @"
Select download directory

Downloadverzeichnis auswählen
"@
$buttonPressed = $folderBrowseDialog.ShowDialog()

if ($buttonPressed -eq "Cancel") {
    $Url
    exit
}

Set-Location $folderBrowseDialog.SelectedPath

$wget = "wget.exe"
# Only download wget if not already found on system
if (-not (Get-Command wget.exe -ErrorAction SilentlyContinue)) {
    Invoke-WebRequest -Uri "https://eternallybored.org/misc/wget/1.20.3/64/wget.exe" -OutFile ".\$wget"
    $cleanupWget = $true
    $wget = ".\wget.exe"
}

$NoOfDirsToCut = ([Uri]$Url).Segments.Count - 1
& $wget --no-check-certificate --recursive --no-clobber --no-parent --no-host-directories --cut-dirs=$NoOfDirsToCut --quiet --show-progress --execute robots=off --reject index.htm* $Url

if ($cleanupWget) {
    $wget | Remove-Item
}

Read-Host "Press any key to exit"
exit