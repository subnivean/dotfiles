# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# /etc/bash.bashrc: executed by bash(1) for interactive shells.

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

source $HOME/dotfiles/env.default
if test -f $HOME/dotfiles/env.local; then
  source $HOME/dotfiles/env.local
fi

# Fixup git-bash in non login env
# shopt -q login_shell || . /etc/profile.d/git-prompt.sh
source /etc/bash_completion.d/git-prompt
PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\]@\[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\]\[\033[0m\] '

shopt -s histappend

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

# Site/Environment-dependent aliases and functions
if [[ "$DFSITE" == "work" ]] ; then
  if [[ "$DFENV" == "wsl" ]] ; then
    alias wscp=/mnt/c/Portable/PortableApps/WinSCPPortable/WinSCPPortable.exe
    function jv
    {
      /mnt/c/Portable/PortableApps/JPEGViewPortable/JPEGViewPortable.exe "$(wslpath -aw $@)" &
    }
    function wm
    {
      /mnt/c/Portable/PortableApps/WinMergePortable/WinMergePortable.exe "$@" &
    }

  elif [[ "$DFENV" == "git-bash" ]] ; then
    alias wscp=/c/Portable/PortableApps/WinSCPPortable/WinSCPPortable.exe
    function jv
    {
      /c/Portable/PortableApps/JPEGViewPortable/JPEGViewPortable.exe "$(cygpath -aw $@)" &
    }
    function vi
    {
      /c/Portable/portableapps/gvimportable/gVimPortable.exe "$@" &
    }
    function wm
    {
      /c/Portable/PortableApps/WinMergePortable/WinMergePortable.exe "$@" &
    }
  fi
fi

# Added 2013-03-31 to get the <TAB> key to cycle through
# possibilities
bind '"\t":menu-complete'

set-title(){
  ORIG=$PS1
  TITLE="\[\e]2;$@\a\]"
  PS1=${ORIG}${TITLE}
}

set-title $DFWINDOWTITLE

if [ -z "$SSH_AUTH_SOCK" ] ; then
      eval `ssh-agent -s`
          ssh-add
fi

if [[ "$DFSITE" == "work" ]]; then
    main_proxy="http://PITC-ZScaler-Global-Zen.proxy.corporate.ge.com:80"
    export http_proxy="$main_proxy"
    export https_proxy="$main_proxy"
    export HTTP_PROXY="$main_proxy"
    export HTTPS_PROXY="$main_proxy"
    export NO_PROXY="github.build.ge.com"
fi

if [[ "$DFSITE" == "home" ]]; then
    export PATH=/usr/bin:$PATH
    export DOCKER_HOST=unix:///run/user/1000/docker.sock
fi

##### HISTORY SETTINGS #####
##### The following from https://stackoverflow.com/questions/9457233/unlimited-bash-history
##### Added 2021-02-01 MSK
# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
##### END HISTORY SETTINGS ####
