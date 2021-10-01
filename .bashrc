#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Add ~/.local/bin to path
export PATH="$HOME/.local/bin:$PATH"
neofetch
source /usr/share/nvm/init-nvm.sh
