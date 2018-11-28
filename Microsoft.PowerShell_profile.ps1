Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key Tab -Function Complete
# Clipboard interaction is bound by default in Windows mode, but not Emacs mode.
Set-PSReadlineKeyHandler -Key Shift+Ctrl+C -Function Copy
Set-PSReadlineKeyHandler -Key Ctrl+V -Function Paste

function tensorflowroot {set-location C:/Users/prs/work_projects/tensorflow/tensorflow}
Set-Alias tr tensorflowroot

function emacsshell {emacs -nw -Q $args}
Set-Alias em emacsshell

function mysearch {gci -r $args}
Set-Alias se mysearch

Set-Alias np "C:\Program Files (x86)\Notepad++\notepad++.exe"
Set-Alias re runemacs

function myls {dir | sort LastWriteTime}
Set-Alias l myls

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
