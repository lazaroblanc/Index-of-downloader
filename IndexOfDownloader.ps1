Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic

# Prompt for Url
$title = '"Index of" downloader'
$msg = "Please enter URL"
$Url = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title, "https://...")

if ($Url.length -eq 0) { exit }
if (-not [Uri]::IsWellFormedUriString($Url, 1)) {
    "Malformed Url" | Write-Error
    exit
}

$NoOfDirsToCut = ([Uri]$Url).Segments.Count - 1
$wgetParams = @(
    "--no-check-certificate"
    "--recursive"
    "--no-clobber"
    "--no-parent"
    "--no-host-directories"
    "--cut-dirs=$NoOfDirsToCut"
    "--quiet"
    "--show-progress"
)

try { $statusCode = (Invoke-WebRequest -Uri $Url -ErrorAction Stop).StatusCode }
catch { $statusCode = [int]$_.Exception.Response.StatusCode; $_ | Write-Error }
while ($statusCode -eq 401) {
    $creds = Get-Credential -Message "401 - The website requires a username/password"
    if ($null -eq $creds) { exit }
    try {
        $statusCode = (Invoke-WebRequest -Uri $Url -Credential $creds -ErrorAction Stop).StatusCode
        $creds = New-Object psobject -Property @{"user" = $creds.UserName; "password" = $creds.GetNetworkCredential().password }
        $wgetParams += "--http-user=$($creds.user)"
        $wgetParams += "--http-password=$($creds.password)"
    }
    catch {
        $_ | Write-Error
    }
}

# Prompt for download location
$folderBrowseDialog = [System.Windows.Forms.FolderBrowserDialog]::new()
$folderBrowseDialog.Description = @"
Select download directory

Downloadverzeichnis auswählen
"@
$buttonPressed = $folderBrowseDialog.ShowDialog()
if ($buttonPressed -eq "Cancel") { exit }
Set-Location $folderBrowseDialog.SelectedPath

# Only download wget if not already found on system
$wget = "wget.exe"
if (-not (Get-Command $wget -ErrorAction SilentlyContinue)) {
    if ([Environment]::Is64BitOperatingSystem) { $architecture = "64" }
    else { $architecture = "32" }
    Invoke-WebRequest -Uri "https://eternallybored.org/misc/wget/1.20.3/$architecture/wget.exe" -OutFile ".\$wget"
    $cleanupWget = $true
    $wget = ".\$wget"
}

& $wget $wgetParams --execute robots=off --reject index.htm* $Url

if ($cleanupWget) { $wget | Remove-Item }

Read-Host "Press any key to exit"
exit
