# check admin
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
$release = ConvertFrom-Json -InputObject (curl https://api.github.com/repos/vim/vim-win32-installer/releases/latest).content

$assets = $release.assets

ForEach($asset in $assets){
    if($asset.name -match '.*\.exe$') {
        Write-Host $nl
        Write-Host $nl
        Write-Host 'downloading vim' -ForegroundColor Magenta
        wget $asset.browser_download_url -OutFile vim_installer.exe
        Write-Host $nl
        Write-Host $nl
        Write-Host 'installing vim' -ForegroundColor Magenta
        ./vim_installer.exe -y
        rm -fo ./vim_installer.exe
        break
    }
}

# downloading vim configuration file
cd $HOME
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/chantisnake/vim_config/master/setup.ps1')
cd .\vimfiles\bundle
Remove-Item vundle.vim -Force -Confirm:$false
git clone https://github.com/VundleVim/Vundle.vim
cd $HOME

# restart
Write-Host 'your computer will restart to finish the setups'
Write-Host 'press Ctrl-c to prevent restarting'
Write-Host 'Press Enter to restart'
Read-Host ''
Restart-Computer

