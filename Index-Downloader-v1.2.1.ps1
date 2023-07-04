#v1.2.1
[CmdletBinding()]
param (
    $Url,
    $Path
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic
Add-Type -AssemblyName PresentationFramework, PresentationCore

if (-not $Url) {
    $window = New-Object System.Windows.Window
    $title = 'Index Downloader'
    $msg = "Enter URL"
    $Url = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title, "")
}
"Url: $Url" | Write-Verbose

if ($Url.length -eq 0) { exit }
if (-not [Uri]::IsWellFormedUriString($Url, 1)) {
    "Malformed URL" | Write-Error
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
    "--restrict-file-names=ascii" # "nocontrol" mode does not work on Windows, UTF-8 filenames are not currently supported.
    "--local-encoding=utf-8"
)

try { $statusCode = (Invoke-WebRequest -Uri $Url -ErrorAction Stop).StatusCode }
catch { $statusCode = [int]$_.Exception.Response.StatusCode; $_ | Write-Error }
while ($statusCode -eq 401) {
    $creds = Get-Credential -Message "Error 401 - Authorization Required"
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

if (-not $Path) {
    $window = New-Object System.Windows.Window

        $folderBrowseDialog = New-Object System.Windows.Forms.FolderBrowserDialog
        $folderBrowseDialog.Description = "Select an output directory"
        $buttonPressed = $folderBrowseDialog.ShowDialog()

        if ($buttonPressed -eq "OK") {
            Set-Location $folderBrowseDialog.SelectedPath
            $window.Close()
        }
}

else {
    Set-Location $Path
}
"Path: $(Get-Location)" | Write-Verbose

if (Test-Path ".\wget.exe") {
    Remove-Item ".\wget.exe"
}

$wget = ".\wget.exe"
if (-not (Test-Path "$wget" -ErrorAction SilentlyContinue)) {
    if ([Environment]::Is64BitOperatingSystem) { $architecture = "64" }
    else { $architecture = "32" }
    "Downloading wget" | Write-Verbose
    Invoke-WebRequest -Uri "https://eternallybored.org/misc/wget/1.21.4/$architecture/wget.exe" -OutFile ".\$wget"
    $cleanupWget = $true
}

"Running wget" | Write-Verbose
& $wget $wgetParams --execute robots=off --reject index.htm* $Url

if ($cleanupWget) { $wget | Remove-Item }

Write-Host "Download Complete!"
Write-Host "Press any key to exit..."
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit
