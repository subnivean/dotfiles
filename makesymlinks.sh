#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################
########## Variables

# Set default envvars
source $HOME/dotfiles/env.default
if test -f $HOME/dotfiles/env.local; then
  source $HOME/dotfiles/env.local
fi

# Override with local envvars if present

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
# Make list of files/folders to symlink in homedir
if [[ ! -z $USER ]] && USER='pi'; then
   files="vimrc bashrc inputrc dirstack gitconfig tmux.conf"
else
   files="vimrc bashrc inputrc dirstack gitconfig tmux.conf"
fi

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# Update the username and email for Git.
#
# To make this work, create a file called `gituser.dat` with
# the following (uncommented) lines:
#
#    name: Your Name
#    email: your.email@you.com
#
echo -n "Updating Git username and email..."
sed "s/<DFGITNAME>/$DFGITNAME/; s/<DFGITEMAIL>/$DFGITEMAIL/" gitconfig_template >|gitconfig
echo "done."
