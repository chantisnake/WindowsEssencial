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

# go to a temp dir
mkdir $HOME/temp
cd $HOME/temp

# construct the newline character
$nl = [Environment]::NewLine

# install chocolatey
Write-Host $nl
Write-Host $nl
Write-Host 'installing choco' -ForegroundColor Magenta
# iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

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
        ./vim_installer.exe |Out-Null
        rm -fo ./vim_installer.exe
        break
    }
}

# installing anaconda2
Write-Host 'fetching anaconda archieve' -ForegroundColor Green
$anacondaUrl = 'https://repo.continuum.io/archive/'
$anacondaWebPage = Invoke-WebRequest $anacondaUrl

Write-Host ' '
Write-Host 'analysing the HTML' -ForegroundColor Green
$anacondaHTML = $anacondaWebPage.parsedHTML
$archieves = $anacondaHTML.body.getElementsByTagName('TR')

foreach ($archieve in $archieves) {
    
    # extract information
    $dataItems = $archieve.children
    $binItem = $dataItems[0]
    $SizeItem = $dataItems[1]
    $timeItem = $dataItems[2]
    $hashItem = $dataItems[3]
    
    if($binItem.innerText -match 'Anaconda2-.*-Windows-x86_64.exe'){  # this is the latest version    
        # output infomation
        $name = $binItem.innerText
        $size = $SizeItem.innerText
        $time = $timeItem.innerText
        $hash = $hashItem.innerText
        Write-Host 'found the latest release of anaconda2'
        Write-Host "name of the file is: $name"
        Write-Host "the size of the file is: $size"
        Write-Host "the last modified time is: $time"
        Write-Host "the hase(MD5) is: $hash"
        
        # download the installer
        Write-Host ' '
        Write-Host 'downloading the anaconda2 installer' -ForegroundColor Green
        Write-Host 'this could takes a while' -ForegroundColor Green
        $fileUrl = "https://repo.continuum.io/archive/$name"
        Start-BitsTransfer $fileUrl ./anaconda2_installer.exe -DisplayName 'Downloading the Latest Version of Anaconda2...'
        
        # check MD5
        Write-Host ' '
        Write-Host 'Checking MD5 value' -ForegroundColor Green
        $localHash = Get-FileHash ./anaconda2_installer.exe -Algorithm MD5 
        if($localHash.Hash.ToUpper() = $hash.ToUpper()){
            Write-Host 'MD5 hash is good'
        }
        else {
            Write-Host 'The MD5 value is not the same, if you continue you maybe exposed to malware or virus' -ForegroundColor Red
            Write-Host 'Please check you network setting and try again. There maybe a proxy setted up' -ForegroundColor Red
            Read-Host 'Press Enter to continue, press Ctrl-C to stop'
        }
        
        # run the installer
        ./anaconda_installer.exe | Out-Null
        break
    }
}

# installing anaconda3
Write-Host 'fetching anaconda archieve' -ForegroundColor Green
$anacondaUrl = 'https://repo.continuum.io/archive/'
$anacondaWebPage = Invoke-WebRequest $anacondaUrl

Write-Host ' '
Write-Host 'analysing the HTML' -ForegroundColor Green
$anacondaHTML = $anacondaWebPage.parsedHTML
$archieves = $anacondaHTML.body.getElementsByTagName('TR')

foreach ($archieve in $archieves) {
    
    # extract information
    $dataItems = $archieve.children
    $binItem = $dataItems[0]
    $SizeItem = $dataItems[1]
    $timeItem = $dataItems[2]
    $hashItem = $dataItems[3]
    
    if($binItem.innerText -match 'Anaconda3-.*-Windows-x86_64.exe'){  # this is the latest version    
        # output infomation
        $name = $binItem.innerText
        $size = $SizeItem.innerText
        $time = $timeItem.innerText
        $hash = $hashItem.innerText
        Write-Host 'found the latest release of anaconda2'
        Write-Host "name of the file is: $name"
        Write-Host "the size of the file is: $size"
        Write-Host "the last modified time is: $time"
        Write-Host "the hase(MD5) is: $hash"
        
        # download the installer
        Write-Host ' '
        Write-Host 'downloading the anaconda2 installer' -ForegroundColor Green
        Write-Host 'this could takes a while' -ForegroundColor Green
        $fileUrl = "https://repo.continuum.io/archive/$name"
        Start-BitsTransfer $fileUrl ./anaconda3_installer.exe -DisplayName 'Downloading the Latest Version of Anaconda2...'
        
        # check MD5
        Write-Host ' '
        Write-Host 'Checking MD5 value' -ForegroundColor Green
        $localHash = Get-FileHash ./anaconda3_installer.exe -Algorithm MD5 
        if($localHash.Hash.ToUpper() = $hash.ToUpper()){
            Write-Host 'MD5 hash is good'
        }
        else {
            Write-Host 'The MD5 value is not the same, if you continue you maybe exposed to malware or virus' -ForegroundColor Red
            Write-Host 'Please check you network setting and try again. There maybe a proxy setted up' -ForegroundColor Red
            Read-Host 'Press Enter to continue, press Ctrl-C to stop'
        }
        
        # run the installer
        ./anaconda_installer.exe | Out-Null
        break
    }
}

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

