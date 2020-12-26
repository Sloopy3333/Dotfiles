#alias

# dot file
alias dot="git --git-dir=$HOME/Dotfiles/ --work-tree=$HOME"

#network
alias scwifi="nmcli d wifi list --rescan yes"
alias cntwifi="nmcli --ask device wifi connect"

#misc
alias yt-songs=youtube-dl --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --output "%(title)s.%(ext)s" 
alias vi='nvim'
alias vim='nvim'
