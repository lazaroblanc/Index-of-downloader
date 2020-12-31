<div align="center">

<h1>"Index of" downloader</h1>
<span>A simple PowerShell script to recursively download all files from an "Index of" page</span>

<br>
</div>

## How do I use it?

1. <a href="https://github.com/lazaroblanc/indexof-downloader/releases/latest">Download the latest release of the script</a>
1. Run the script `DownloadIndexOf.ps1` via:
    1. `Right-Click` and selecting `Run with PowerShell`
    1. or by calling it from the command-line: `PS > DownloadIndexOf.ps1`

<div align="center">
<img src="https://i.imgur.com/ectqjd1.gif">
</div>

## Why not just use `wget`?

I occasionally find myself sharing large files with friends and family that I have hosted on a private webserver.

Since I usually split very large files into multiple parts I wanted them to be able to download the multiple files easily without the need to get additional software or knowing how to use it (like `wget` or *JDownloader*)

This does exactly that while being *user-friendly* at the same time.<br>
The user gets a WinForms GUI prompt for entering the URL and the download location.
Afterwards the download is started and shown with a progress indicator (courtesy of `wget`)

Now I can just give them this script with a URL to where the downloads are *et-voila*: No hassle for me or for them! :)

## Limitations (aka. What this script can't do for you)

1. While this Script will run in Windows PowerShell (v3.0 - v5.1) and PowerShell (>= v6) it **works only under Windows** since it uses the Windows Binaries for `wget` and the WinForms library for the GUI elements

1. If `wget` is not installed on the target machine it will download the 64-bit Binary. Thus this script **will not work on 32-bit hosts**.

1. I've used *reasonable* arguments for `wget` in the script. There currently is no need to use different arguments nor is there a way to supply your own arguments to the `wget` instance in this script. Feel free to modify them in the script itself or add a way for you to pass them into the script via a parameter(s). In that case I would welcome a pull request! :) I however do not currently need this functionality.

1. No support for HTTP authentication methods. You can pass `--http-user` and `--http-password` as an argument to `wget` yourself. (See above)

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