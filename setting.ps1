# generating ssh-key
Write-Host $nl
Write-Host $nl
Write-Host 'setting up git ssh key' -ForegroundColor Magenta
Set-Location 'C:\Program Files\Git\usr\bin'
Invoke-Expression './ssh-keygen.exe -t rsa -b 4096 -C "13501393281@163.com"'
Invoke-Expression './ssh-agent -s'
Invoke-Expression "./ssh-add.exe $HOME/.ssh/id_rsa"
# copy ssh key to clip board
cat "$HOME\.ssh\id_rsa.pub" |clip
Write-Host 'your ssh agent is setted up and your ssh key is copied to clip board'
Read-Host 'press enter to continue'

# downloading vim configuration file
Write-Host $nl
Write-Host $nl
Write-Host 'setting up vim' -ForegroundColor Magenta
cd $HOME
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/chantisnake/vim_config/master/setup.ps1')
Write-Host 'redownloading vundle' -ForegroundColor Magenta
cd .\vimfiles\bundle
Remove-Item vundle.vim -Force -Confirm:$false
git clone https://github.com/VundleVim/Vundle.vim
Invoke-Expression 'vim +PluginInstall +qall'
cd $HOME

