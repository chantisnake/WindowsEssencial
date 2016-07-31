nst# check admin
function isAdmin { 
      $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent() 
      $principal = new-object System.Security.Principal.WindowsPrincipal($identity) 
      $admin = [System.Security.Principal.WindowsBuiltInRole]::Administrator 
      $principal.IsInRole($admin) 
}
if(-Not(isAdmin)){
    Write-Host 'you are not runing as admin' -ForegroundColor Magenta
    Exit 
}

# go to a temp dir
mkdir $HOME/temp
cd $HOME/temp

# construct the newline character
$nl = [Environment]::NewLine

# install chocolatey
Write-Host $nl
Write-Host $nl
Write-Host 'installing choco' -ForegroundColor Magenta
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# install git
Write-Host $nl
Write-Host $nl
Write-Host 'installing git' -ForegroundColor Magenta
choco install -y git

# install ctags
Write-Host $nl
Write-Host $nl
Write-Host 'installing ctags' -ForegroundColor Magenta
choco install -y ctags

# install everything
Write-Host $nl
Write-Host $nl
Write-Host 'installing everything' -ForegroundColor Magenta
choco install -y everything

# install vscode
Write-Host $nl
Write-Host $nl
Write-Host 'installing vscode' -ForegroundColor Magenta
choco install -y visualstudiocode

# install miktex
Write-Host $nl
Write-Host $nl
Write-Host 'installing Miktex' -ForegroundColor Magenta
choco install -y miktex

# install sumatrapdf
Write-Host $nl
Write-Host $nl
Write-Host 'installing sumatraPDF' -ForegroundColor Magenta
choco install -y sumatrapdf

# install 7z
Write-Host $nl
Write-Host $nl
Write-Host 'installing 7z' -ForegroundColor Magenta
choco install -y 7zip.install

# install aegisub
Write-Host $nl
Write-Host $nl
Write-Host 'installing aegisub' -ForegroundColor Magenta
choco install -y aegisub

# install python2
Write-Host $nl
Write-Host $nl
Write-Host 'installing python2' -ForegroundColor Magenta
choco install -y python2

# install nodejs
Write-Host $nl
Write-Host $nl
Write-Host 'installing node' -ForegroundColor Magenta 
choco install -y nodejs


# download the latest release of vim
Write-Host $nl
Write-Host $nl
Write-Host 'installing vim' -ForegroundColor Magenta 
choco install vim-tux

# installing anaconda2
Write-Host $nl
Write-Host $nl
Write-Host 'installing anaconda2' -ForegroundColor Magenta 
choco install anaconda2

# installing anaconda3
Write-Host $nl
Write-Host $nl
Write-Host 'installing anaconda3' -ForegroundColor Magenta 
choco install anaconda3

# downloading wechat
$url = 'http://dlglobal.qq.com/weixin/Windows/WeChat_C1018.exe'
Start-BitsTransfer $fileUrl ./wechat_installer.exe -DisplayName 'Downloading the Latest Version of wechat...'
./wechat_installer.exe |Out-Null

# clean up
cd $HOME
Remove-Item temp/ -Force -Re -Confirm:$false

# restart
Write-Host 'your computer will restart to finish the setups'
Write-Host 'press Ctrl-c to prevent restarting'
Read-Host 'Press Enter to restart'
Restart-Computer

