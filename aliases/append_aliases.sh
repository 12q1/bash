# This script **appends** the ~/.bash_aliases file with
# custom aliases and binds that I use.
# If you don't want to append aliases just copy .bash_aliases to your home folder
# Running this script multiple times will mess up your ~/.bash_aliases file

touch ~/.bash_aliases
#creates .bash_aliases in home folder if one doesn't exist

echo '------------------------------------------------------'
echo -e '\e[1;36m Pushing custom aliases to ~/.bash_aliases \e[0m'
echo '------------------------------------------------------'

echo "alias ..='cd ..'" >> ~/.bash_aliases

echo "alias cleanUp='sudo apt autoclean -y && sudo apt clean && sudo apt autoremove'" >> ~/.bash_aliases

echo "alias duh='du -sh'" >> ~/.bash_aliases

echo "alias install='sudo apt install'" >> ~/.bash_aliases

echo "alias myip='curl http://ipecho.net/plain; echo'" >> ~/.bash_aliases
# requires curl

echo "alias remove='sudo apt remove --purge'" >> ~/.bash_aliases

echo "alias reboot='sudo reboot'" >> ~/.bash_aliases

echo "alias shutdown='sudo shutdown'" >> ~/.bash_aliases

echo "alias trash='trash-put'" >> ~/.bash_aliases
# requires trash-cli

echo "alias updateAll='sudo apt update && sudo apt upgrade'" >> ~/.bash_aliases

echo "alias ytmp3='youtube-dl -x --audio-format mp3'" >> ~/.bash_aliases
# requires youtube-dl

echo "alias transp=\"sh -c 'xprop -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY \$(printf 0x%x $((0xffffffff * 80 / 100)))'\"" >> ~/.bash_aliases
# next window you click will become transparent

echo '------------------------------------------------------'
echo -e '\e[1;36m Pushing custom binds to ~/.bash_aliases \e[0m'
echo '------------------------------------------------------'
# should make a separate file for this if it grows

echo "bind 'set completion-ignore-case on' #ignores case in autocomplete" >> ~/.bash_aliases

echo "bind 'set show-all-if-ambiguous on' #single tab for autocomplete" >> ~/.bash_aliases

echo '------------------------------------------------------'
echo -e '\e[1;36m Done - Applying Changes \e[0m'
echo '------------------------------------------------------'
source ~/.bashrc

#EOF