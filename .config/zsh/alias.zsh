#alias

# dot file
alias dot="git --git-dir=$HOME/Dotfiles/ --work-tree=$HOME"

#network
alias scwifi="nmcli d wifi list --rescan yes"
alias cntwifi="nmcli --ask device wifi connect"
alias wifion="nmcli radio wifi on"
alias wifioff="nmcli radio wifi off"

#misc
alias vi='nvim'
alias vim='nvim'

# devour
alias sxiv="devour sxiv"
alias mpv="devour mpv"
alias zathura="devour zathura"
