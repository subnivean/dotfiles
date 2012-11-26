# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

set -o vi

# workaround for gvim under Ubuntu/Unity (fixed in 12.10)
#function vi() { /usr/bin/gvim -f $* & }

copy_to_whiting()
{
  scp -i /home/mark/.ssh/schools_id_rsa -rp $1 whitek12@whiting.k12.vt.us:
}

copy_to_sudbury()
{
  scp -i /home/mark/.ssh/schools_id_rsa -rp $1 sudbuk12@sudbury.k12.vt.us:
}

copy_to_leicester()
{
  scp -i /home/mark/.ssh/schools_id_rsa -rp $1 leick12@leicester.k12.vt.us:
}

copy_to_lothrop()
{
  scp -i /home/mark/.ssh/schools_id_rsa -rp $1 lothrk12@lothrop.k12.vt.us:
}

copy_from_whiting()
{
  scp -i /home/mark/.ssh/schools_id_rsa -rp whitek12@whiting.k12.vt.us:$1 .
}

copy_from_sudbury()
{
  scp -i /home/mark/.ssh/schools_id_rsa -rp sudbuk12@sudbury.k12.vt.us:$1 .
}

copy_from_leicester()
{
  scp -i /home/mark/.ssh/schools_id_rsa -rp leick12@leicester.k12.vt.us:$1 .
}

copy_from_lothrop()
{
  scp -i /home/mark/.ssh/schools_id_rsa -rp lothrk12@lothrop.k12.vt.us:$1 .
}

function gdt
{
  git difftool "$@" &
}

# Got 'parse_git_branch', and the PS1 that uses it, from:
#   http://betterexplained.com/articles/aha-moments-when-learning-git/
# Thanks, Anil!
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[00m\]\u@\h\[\033[01;34m\] \W\[\033[31m\]\$(parse_git_branch) \[\033[00m\]$\[\033[00m\] "

# User specific aliases and functions

source ~/.dir_functions
source ~/.bash_aliases
source ~/.bash_aliases_mach

alias pics='cd /media/chinstrap/smbshares/shared/Pics/Raw/Recent'
export PICS='/media/chinstrap/smbshares/shared/Pics/Raw/Recent'
alias cww='ar1=($(find ~/bashpodder -name "npr*.mp3")); if [ "${ar1[0]}" != "" ]; then ar2=($(ls -t "${ar1[@]}")); cp ${ar2[0]} /media/sda1/audio; else echo "Nothing to burn!"; fi'
alias bww='ar1=($(find ~/bashpodder -name "npr*.mp3")); if [ "${ar1[0]}" != "" ]; then ar2=($(ls -t "${ar1[@]}")); ln -sf ${ar2[0]} ~/wwdtm/wwdtm.mp3; k3b ~/wwdtm/wwdtm.k3b 2>/dev/null; else echo "Nothing to burn!"; fi'
alias vpnc='sudo sh -c /usr/sbin/vpnc'
alias vpnc-disconnect='sudo sh -c /usr/sbin/vpnc-disconnect'
alias beemanstat="ssh oldgrinder 'cd Beeman_WebShell2; ./putscript.pl genstatus'"
alias ogtvlm="ssh -l root oldgrinder tail -100 /var/log/messages"
alias ogdmesg="ssh -l root oldgrinder dmesg"
#alias gpsout="sudo gpsbabel -t -D2 -i garmin -f /dev/ttyS0 -o gpx -F $1"
alias gpsout="ruby ~/ruby/gpsout.rb"
alias ef="perl ~/ef"
alias fe="perl ~/fe"
alias emd="cd /mnt/jezebel/music/emusic_downloads"
alias pf="/usr/local/bin/play_file"
#alias mj="sudo modprobe fuse; sshfs jezebel:/home/mark/music /media/jukebox"
alias mcs="sshfs 192.168.0.1:/ /home/mark/chinstrap"
alias mj="sshfs 192.168.0.52:/home/mark/music /media/jukebox"
alias umj="fusermount -u /media/jukebox"
alias eel="vi ~/exercise/log"
#alias vi="/usr/bin/vim"
#alias vim="vim -g"
alias sq="sqlite3"
alias smc="ssh mathcoun@mathcountsswvt.net"
alias se="ssh -i /home/mark/.ssh/expeto_backup_rsa expetoor@expeto.org"
alias spp="ssh -i /home/mark/.ssh/penguinproductions_rsa penguin3@penguinproductionsdjs.com"
alias mmc="sshfs mathcoun@mathcountsswvt.net: /home/mark/mathcountsswvt"
alias umc="fusermount -u /home/mark/mathcountsswvt"
alias mex="sshfs expetoor@expeto.org: /home/mark/expeto -o IdentityFile=/home/mark/.ssh/expeto_backup_rsa"
alias umx="fusermount -u /home/mark/expeto"
alias et="ssh -i /home/mark/.ssh/expeto_backup_rsa -t expetoor@expeto.org top"
alias ew="ssh -i /home/mark/.ssh/expeto_backup_rsa expetoor@expeto.org w"

export LEICESTER="leick12@leicester.k12.vt.us"
export LOTHROP="lothrk12@lothrop.k12.vt.us"
export SUDBURY="sudbuk12@sudbury.k12.vt.us"
export WHITING="whitek12@whiting.k12.vt.us"
export SCHOOL_KEY="/home/mark/.ssh/schools_id_rsa"
export SCHOOLS="$LEICESTER $LOTHROP $SUDBURY $WHITING"
alias sle="ssh -i $SCHOOL_KEY $LEICESTER"
alias slo="ssh -i $SCHOOL_KEY $LOTHROP"
alias ssu="ssh -i $SCHOOL_KEY $SUDBURY"
alias swh="ssh -i $SCHOOL_KEY $WHITING"
alias sss="ssh -i $SCHOOL_KEY"

alias ctwh="copy_to_whiting $1"
alias ctsu="copy_to_sudbury $1"
alias ctle="copy_to_leicester $1"
alias ctlo="copy_to_lothrop $1"

alias cfwh="copy_from_whiting $1"
alias cfsu="copy_from_sudbury $1"
alias cfle="copy_from_leicester $1"
alias cflo="copy_from_lothrop $1"

alias mt="ssh -t mathcoun@mathcountsswvt.net top"
alias mw="ssh mathcoun@mathcountsswvt.net w"
alias ctm="/home/mark/copy_to_mathcounts.bash"

alias kh="konqueror . & 2>/dev/null"
alias dh="dolphin . &"
alias eh="nautilus . 2>/dev/null"

alias sshsud="ssh -i ~/.ssh/sudz_key root@sudz"
alias sshsudx="ssh -X -i ~/.ssh/sudz_key root@sudz"

alias sas="sudo apt-cache search"
alias sai="sudo apt-get install"
alias wtf="ssh -l penguin3 penguinproductionsdjs.com 'find public_html -type f -mmin -60 |xargs ls -l'"

alias gitk='gitk --all&'
alias qgit='qgit --all&'
alias cu='cd ..'

export HISTTIMEFORMAT='%Y-%m-%dT%H:%M:%S '
export HISTSIZE=10000
export HISTFILESIZE=10000
shopt -s histappend
export PROMPT_COMMAND='history -a'

export MATHCOUNTS='/media/sda2/MathCounts/';

alias temp='echo "$(cat /proc/acpi/thermal_zone/THM/temperature  |cut -c25-27)*9/5+32" |bc'

# Settings for Ruby's 'ri' command-line doc system - 'man ri' for more info
export RI="--format ansi --width 70 --no-pager"
#PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER \
#               "$(history 1)" >> ~/.bash_eternal_history'

alias vshow='cvlc -q --play-and-exit'
alias emp='ecryptfs-mount-private'

# Set file permissions to '666' so susan can read/write in public_html
alias gst='git status'
alias gb='git branch'

alias vv='cat /home/mark/Private/.ssh/vtvlc_visualhostkey; ssh -o VisualHostKey=true -i /home/mark/Private/.ssh/vtvlc_login_rsa jeffrenard@vtvlc.org'
#alias hx='ssh -X 192.168.0.118'
alias hx='ssh -X 192.168.0.119'

export CSF_GraphicShr=/usr/lib/libTKOpenGl-6.3.0.so
export TERM=xterm-256color

CERT='cert-VB5KFMTNIKUFJTNVCY2NBNX4MNFWGXDT'
EC2KEY='pk-VB5KFMTNIKUFJTNVCY2NBNX4MNFWGXDT'
export EC2_PRIVATE_KEY="$HOME/.ssh/${EC2KEY}.pem"
export EC2_CERT="$HOME/.ssh/${CERT}.pem"

export PYTHONPATH=/home/mark/python:/home/mark/python/scikit-learn
alias gam='python ~/gam/gam.py'

# VPN logins
alias vwhi='ssh root@192.168.3.10' # Whiting
alias vlot='ssh root@192.168.2.4'  # Lothrop