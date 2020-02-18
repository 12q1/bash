alias ..='cd ..'
alias cleanUp='sudo apt autoclean -y && sudo apt clean && sudo apt autoremove'
alias duh='du -sh'
alias install='sudo apt install'
alias myip='curl http://ipecho.net/plain; echo'
alias remove='sudo apt remove --purge'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown'
alias trash='trash-put'
alias updateAll='sudo apt update && sudo apt upgrade'
alias ytmp3='youtube-dl -x --audio-format mp3'
alias transp="sh -c 'xprop -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY 0xcccccccc'"
bind 'set completion-ignore-case on' #ignores case in autocomplete
bind 'set show-all-if-ambiguous on' #single tab for autocomplete
