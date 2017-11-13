# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# /etc/bash.bashrc: executed by bash(1) for interactive shells.

# System-wide bashrc file

# Check that we haven't already been sourced.
([[ -z ${CYG_SYS_BASHRC} ]] && CYG_SYS_BASHRC="1") || return

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Set a default prompt of: user@host, MSYSTEM variable, and current_directory
# MSK 2016-11-16 - Don't touch this; let the 'git-prompt.sh' script in
# /etc/profile.d handle it.
#PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n\$ '

# Uncomment to use the terminal colours set in DIR_COLORS
# eval "$(dircolors -b /etc/DIR_COLORS)"

# Fixup git-bash in non login env
# shopt -q login_shell || . /etc/profile.d/git-prompt.sh
source /etc/bash_completion.d/git-prompt
PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\]@\[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] '
#export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWCOLORHINTS=1
#export GIT_PS1_SHOWUNTRACKEDFILES=1
#export PROMPT_COMMAND=' __git_ps1 "\n[\e[33m][[\e[m]\A [\e[31m]\u[\e[m]@[\e[32m]\h [\e[34;01m]\l[\e[m] [\e[36m]\w[\e[m]" "[\e[33m]][\e[m]\n$ "'

###########################
# MSK additions 2016-11-16
###########################
shopt -s histappend
PROMPT_COMMAND='history -a'

set -o noclobber
set -o vi

# Get cool directory-changing functions (type 'd') at prompt for list
if [ ! -f ~/.dirstack ]; then touch ~/.dirstack; fi
#source /etc/profile.d/dirfuncs.sh  # My very own
source $HOME/dotfiles/dirfuncs.sh  # My very own

PYTHON352T="/c/Leport-WinPython-64bit-3.5.2.3-testing/WinPython-64bit-3.5.2.3/python-3.5.2.amd64"
PYTHON352="/c/Leport/WinPython-64bit-3.5.2.3/python-3.5.2.amd64"
PYTHON279="/c/Leport/WinPython-32bit-2.7.9.2/python-2.7.9"
PYTHON275="/c/Leport/WinPython-32bit-2.7.5.3-ipython2/python-2.7.5"

PORT1="C:/Portable/PortableApps"
PORT2="C:/LEPort"
PORT3="C:/Rut/Portable/PortableApps"

if [ -d "$PORT1" ]; then
    export PORTABLE="$PORT1"
elif [ -d "$PORT2" ]; then
    export PORTABLE="$PORT2"
elif [ -d "$PORT3" ]; then
    export PORTABLE="$PORT3"
# else
#     echo 'PORTABLE not set'
fi

PATH=/c/users/210008038/bin:$PATH

function vi
{
    $PORTABLE/gvimportable/gVimPortable.exe "$@" &
}

function wm
{
    $PORTABLE/winmergeportable/winmergeportable.exe "$@" &
}

function pe
{
    $PORTABLE/procexp.exe "$@" &
}

function ea
{
   explorer $(eval cygpath -aw "\$D${1}") &
}

function jv
{
    $PORTABLE/jpegviewportable/jpegviewportable.exe "$(cygpath -aw $@)" &
}

function jvr
# Open most recent file
{
    f="$(find . -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tif" -o -iname "*.jpg" |xargs ls -t |head -n1)"
    $PORTABLE/jpegviewportable/jpegviewportable.exe "$(cygpath -aw $f)" &
}

function gvimdiff
{
    f1="$(cygpath -m $1)"
    f2="$(cygpath -m $2)"

    PATH="$PORTABLE/gvimportable/App/vim/vim80/:$PATH" && $PORTABLE/gvimportable/gvimportable.exe -d "$f1" "$f2" &
}

alias ll='ls -l --color=always'
alias lt='ls -lt --color=always'
alias ltm="ls -lt --color=always |less --RAW-CONTROL-CHARS"
alias ltr='ls -ltr --color=always|head -n24'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias eh='explorer . &'
alias wget="$PORTABLE/WinWGetPortable/app/winwget/wget/wget.exe"
alias sqlite="/C/Users/210008038/bin/sqlite3.exe"
alias sqliteb="$PORTABLE/SQLiteDatabaseBrowserPortable/SQLiteDatabaseBrowserPortable.exe"
alias putty="$PORTABLE/PuttyPortable/PuttyPortable.exe"
alias fz="$PORTABLE/FileZillaPortable/FilezillaPortable.exe"
alias vd=gvimdiff

# Git aliases
alias gst="git status"
alias gd="git diff"
alias gdt="git difftool"
alias gb="git branch"
alias gco="git checkout"
alias gci="git commit"
alias ga="git add"
alias gitcheck="$PYTHON352/python.exe $PYTHON352/Lib/site-packages/gitcheck/gitcheck.py"

# Added 2013-03-31 to get the <TAB> key to cycle through
# possibilities
bind '"\t":menu-complete'

alias python352t="$PYTHON352T/python.exe"
alias python352="$PYTHON352/python.exe"
alias python279="$PYTHON279/python.exe"
alias python275="$PYTHON275/python.exe"

alias ipy275="cygstart /c/LEPort/IPython\ for\ LEP.lnk"
alias ipy279="cygstart /c/LEPort/IPython\ for\ LEP\ \(WP\ 2.7.9.2\).lnk"
alias ipy279test="cygstart /c/LEPort/IPython\ for\ LEP\ \(WP\ 2.7.9.2-testing\).lnk"
alias ipy352="cygstart /c/LEPort/IPython\ for\ IGV\ \(WP\ 3.5.2.3\).lnk"
alias ipytemill="cygstart /c/Rut/TEMill/IPython\ for\ TEMill.lnk"

alias vanes="cygstart /c/LEPort/IPython\ for\ Vanes\ \(WP\ 3.5.2.3\).lnk"

alias msk275="cd /c/LEPort/WinPython-32bit-2.7.5.3-ipython2/python-2.7.5/Lib/site-packages/msk"
alias msk279="cd /c/LEPort/WinPython-32bit-2.7.9.2/python-2.7.9/Lib/site-packages/msk"
alias msk352="cd /c/LEPort/WinPython-64bit-3.5.2.3/python-3.5.2.amd64/Lib/site-packages/msk"

alias rsc01="$PORTABLE/PuttyPortable/PuttyPortable.exe -load rsc01 &"

# Liechti Mill aliases/evars
alias l10='cd //3.31.92.49/C$/Rut/'
alias l11='cd //3.31.92.38/C$/Rut/'
alias l20='cd //3.31.92.40/C$/Rut/'
alias l21='cd //3.31.92.35/C$/Rut/'
alias l30='cd //3.31.92.33/C$/Rut/'
alias l31='cd //3.31.92.30/C$/Rut/'
alias l40='cd //3.31.92.32/C$/Rut/'
alias l41='cd //3.31.92.31/C$/Rut/'
alias l50='cd //3.31.92.36/C$/Rut/'
alias l51='cd //3.31.92.34/C$/Rut/'
alias l52='cd //3.31.92.39/C$/Rut/'
alias l53='cd //3.31.92.37/C$/Rut/'
export L10='//3.31.92.49/C$/Rut/'
export L11='//3.31.92.38/C$/Rut/'
export L20='//3.31.92.40/C$/Rut/'
export L21='//3.31.92.35/C$/Rut/'
export L30='//3.31.92.33/C$/Rut/'
export L31='//3.31.92.30/C$/Rut/'
export L40='//3.31.92.32/C$/Rut/'
export L41='//3.31.92.31/C$/Rut/'
export L50='//3.31.92.36/C$/Rut/'
export L51='//3.31.92.34/C$/Rut/'
export L52='//3.31.92.39/C$/Rut/'
export L53='//3.31.92.37/C$/Rut/'

# CMM aliases/evars
alias c01='cd //3.51.225.146/C$/blade_inspection_data/'
alias c02='cd //3.51.225.179/C$/blade_inspection_data/'
alias c03='cd //3.51.224.237/C$/blade_inspection_data/'
alias c04='cd //3.51.198.105/C$/blade_inspection_data/'
alias c05='cd //3.51.198.133/C$/blade_inspection_data/'
alias c06='cd //3.51.224.179/C$/blade_inspection_data/'
alias c07='cd //3.51.199.7/C$/blade_inspection_data/'
alias c08='cd //3.51.224.233/C$/blade_inspection_data/'
alias c09='cd //3.51.199.8/C$/blade_inspection_data/'
alias c10='cd //3.51.199.166/C$/blade_inspection_data/'
alias c11='cd //3.51.198.157/C$/blade_inspection_data/'
alias c12='cd //3.51.224.148/C$/blade_inspection_data/'
alias c13='cd //3.51.224.190/C$/blade_inspection_data/'
export C01='//3.51.225.146/C$/blade_inspection_data/'
export C02='//3.51.225.179/C$/blade_inspection_data/'
export C03='//3.51.224.237/C$/blade_inspection_data/'
export C04='//3.51.198.105/C$/blade_inspection_data/'
export C05='//3.51.198.133/C$/blade_inspection_data/'
export C06='//3.51.224.179/C$/blade_inspection_data/'
export C07='//3.51.199.7/C$/blade_inspection_data/'
export C08='//3.51.224.233/C$/blade_inspection_data/'
export C09='//3.51.199.8/C$/blade_inspection_data/'
export C10='//3.51.199.166/C$/blade_inspection_data/'
export C11='//3.51.198.157/C$/blade_inspection_data/'
export C12='//3.51.224.148/C$/blade_inspection_data/'
export C13='//3.51.224.190/C$/blade_inspection_data/'
