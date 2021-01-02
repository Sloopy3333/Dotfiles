#alias

# ls
alias ls="exa --color=always --group-directories-first"
alias la="exa -a --color=always --group-directories-first"
alias lla="exa -la --color=always --group-directories-first"

# grep
alias grep="grep --color=auto"

# dot file repo
alias dot="git --git-dir=$HOME/Dotfiles/ --work-tree=$HOME"
alias status="dot status"
alias stage="dot stage"
alias stageall="dot stage -A"
alias commit="dot commit -m"
alias push="dot push origin master"

#network
alias scwifi="nmcli d wifi list --rescan yes"
alias cntwifi="nmcli --ask device wifi connect"
alias wifion="nmcli radio wifi on"
alias wifioff="nmcli radio wifi off"

#misc
alias vi='nvim'
alias vim='nvim'

# devour
alias steam="devour prime-run steam"
alias sxiv="devour sxiv"
alias mpv="devour mpv"
alias zathura="devour zathura"
