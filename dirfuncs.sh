# An MSK creation, from a long time ago...
save_dirstack()
{
    # Assign environment variables, and save settings to a 
    # file that we can source at future logins.

    # Need this to properly handle paths/filenames with whitespace
    def_IFS="$IFS" 
    IFS=$'\n' 

    # Get the length of the directory stack
    n=${#DIRSTACK[*]}

    # Empty the file
    echo -n "" >|~/.dirstack 

    # Loop through directories in the stack, in reverse order
    for dir in $(dirs -l -p |tac) 
    do

        # Write the `pushd` command to the file
        echo "builtin pushd -n \"$dir\" >/dev/null" >> ~/.dirstack

        # Assign the directory to an environment variable
        n=$(( $n - 1 ))
        export D$n="$dir"

    done

    # Force cd to home after pushd above (start of session)
    echo "cd \"$HOME\"" >> ~/.dirstack 

    # Reset the IFS to standard behaviour
    IFS="$def_IFS"
}

pushd()
{
    builtin pushd "$@" > /dev/null
    while [ ${#DIRSTACK[*]} -gt 31 ]
    do
        # Remove last element
        popd -n -0 >/dev/null  
    done

        # Filter duplicates from DIRSTACK (couldn't figure out
        # how to do this purely in the shell; lack of hashes
        # to make a 'key counter' hurt)
        #
    for n in $(dirs -l -p | perl -ne 'if($seen{$_}++){print "$cnt\n"} else {$cnt++}')
    do
        popd -n +$n >/dev/null
    done

    save_dirstack
}

swap_dirstack() 
{
    pushd +$1 >/dev/null
    td=$(dirs -l -p |head -n1)
    popd >/dev/null
    builtin pushd -$(( $1 - 1 )) >/dev/null
    builtin pushd "$td" >/dev/null
    dirs -v

    save_dirstack
}

alias 1='swap_dirstack 1'
alias 2='swap_dirstack 2'
alias 3='swap_dirstack 3'
alias 4='swap_dirstack 4'
alias 5='swap_dirstack 5'
alias 6='swap_dirstack 6'
alias 7='swap_dirstack 7'
alias 8='swap_dirstack 8'
alias 9='swap_dirstack 9'
alias 10='swap_dirstack 10'
alias 11='swap_dirstack 11'
alias 12='swap_dirstack 12'
alias 13='swap_dirstack 13'
alias 14='swap_dirstack 14'
alias 15='swap_dirstack 15'
alias 16='swap_dirstack 16'
alias 17='swap_dirstack 17'
alias 18='swap_dirstack 18'
alias 19='swap_dirstack 19'
alias 20='swap_dirstack 20'
alias 21='swap_dirstack 21'
alias 22='swap_dirstack 22'
alias 23='swap_dirstack 23'
alias 24='swap_dirstack 24'
alias 25='swap_dirstack 25'
alias 26='swap_dirstack 26'
alias 27='swap_dirstack 27'
alias 28='swap_dirstack 28'
alias 29='swap_dirstack 29'
alias 30='swap_dirstack 30'

# alias cd so it uses the directory stack function above
alias cd='pushd'

# Convenient way of viewing the directory stack
alias d='dirs -v'

# Re-create the environment variables representing the dirstack the
# last time we logged out.
source ~/.dirstack
