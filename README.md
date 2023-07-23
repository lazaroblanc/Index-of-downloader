<div align="center">
    
# `Index Downloader`
#### A simple PowerShell script used to recursively download files from a webserver's "Index of" page.
    
<br>
    
</div>


## Features & Compatibility
- uses `wget` to retrieve files
- uses GUI elements for the output selection
- Progress indicators
- Support for HTTP authentication methods
- Runs using Windows PowerShell v3.0 - v5.1 & PowerShell v6+

## How do I use it?
1. Run the script `Index-Downloader-v#.#.#.ps1` via:
    - `Right-Click` and selecting `Run with PowerShell`
<br>

<div align="center">
<img src="https://i.imgur.com/ectqjd1.gif">
</div>

## Limitations
1. Works only on Windows.
    - Windows Binaries are used for `wget`
    - Relyes on the WinForms library for GUI elements.
2. Non-ASCII filenames (like UTF-8) are not supported.
    - This is due to limitations on Windows. 
    - Non-ASCII characters be escaped.
