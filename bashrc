# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# /etc/bash.bashrc: executed by bash(1) for interactive shells.

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Fixup git-bash in non login env
# shopt -q login_shell || . /etc/profile.d/git-prompt.sh
source /etc/bash_completion.d/git-prompt
PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\]@\[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\]\[\033[0m\] '

shopt -s histappend
PROMPT_COMMAND='history -a'

set -o noclobber
set -o vi

# Get cool directory-changing functions (type 'd') at prompt for list
if [ ! -f ~/.dirstack ]; then touch ~/.dirstack; fi

source $HOME/dotfiles/dirfuncs.sh  # My very own

alias ll='ls -l --color=always'
alias lt='ls -lt --color=always'
alias ltm="ls -lt --color=always |less --RAW-CONTROL-CHARS"
alias ltr='ls -ltr --color=always|head -n24'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Git aliases
alias gst="git status"
alias gd="git diff"
alias gdt="git difftool"
alias gb="git branch"
alias gco="git checkout"
alias gci="git commit"
alias ga="git add"
alias gl="git log"

# tmux
alias tma="tmux attach"

# Added 2013-03-31 to get the <TAB> key to cycle through
# possibilities
bind '"\t":menu-complete'
