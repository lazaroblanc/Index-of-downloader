<div align="center">

<h1>"Index of" downloader</h1>
<span>A simple PowerShell script to recursively download all files from an "Index of" page</span>
<br><br>
<a href="https://github.com/lazaroblanc/indexof-downloader/releases/latest"><img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/lazaroblanc/indexof-downloader">
<img alt="GitHub all releases" src="https://img.shields.io/github/downloads/lazaroblanc/indexof-downloader/total"></a>
<a href="./UNLICENSE"><img alt="GitHub" src="https://img.shields.io/github/license/lazaroblanc/indexof-downloader?color=informational"></a>
<br>
</div>

## How do I use it?

1. <a href="https://github.com/lazaroblanc/indexof-downloader/releases/latest">Download the latest release</a>
1. Run the script `IndexOfDownloader.ps1` via:
    - `Right-Click` and selecting `Run with PowerShell`
    - the command-line: `.\IndexOfDownloader.ps1`


<div align="center">
<img src="https://i.imgur.com/ectqjd1.gif">
</div>

## Features

- uses `wget` to retrieve files
- uses GUI elements for prompts to the user
- Progress indicators
- Support for HTTP authentication methods

## Why not just use `wget` from the cli?

I've occasionally found myself sharing large files with friends and family that I have hosted on a private webserver.

Since I usually split very large files into multiple parts I wanted them to be able to download the multiple files easily without the need to get additional software or knowing how to use it (like `wget` or *JDownloader*)

This does exactly that while being *user-friendly* at the same time.<br>
The user gets a WinForms GUI prompt for entering the URL and the download location.
Afterwards the download is started and shown with a progress indicator.

Now I can just give them this script with a URL to where the downloads are *et-voila*: No hassle for me or for them! :)

## Limitations (aka. What this script can't do for you)

1. While this Script will run in Windows PowerShell (v3.0 - v5.1) and PowerShell (>= v6) it **works only under Windows** since it uses the Windows Binaries for `wget` and the WinForms library for the GUI elements

1. I've used *reasonable* arguments for `wget` in the script. There currently is no need to use different arguments nor is there a way to supply your own arguments to the `wget` instance in this script. Feel free to modify them in the script itself or add a way for you to pass them into the script via a parameter(s). In that case I would welcome a pull request! :) I however do not currently need this functionality.

<div align="center">
<hr>
<table>
<tr>
<td colspan=2>
<h2>🐛 Bug reports & Feature requests 🆕</h2>
If you've found a bug or want to request a new feature please <a href="https://github.com/lazaroblanc/discord-bot/issues/new">open a new <b>Issue</b></a>
<br><br>
</td>
</tr>
<tr>
<td>
<h2>🤝 Contributing</h2>
✅ Pull requests are welcome!
<br><br>
</td>
<td>
<h2>📃 License</h2>
Published under "The Unlicense"<br>
Please see the <a href="./UNLICENSE"><b>License</b></a> for details
<br><br>
</td>
</tr>
</table>
</div>
