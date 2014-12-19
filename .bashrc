#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'


# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh

#PS1='[\u:\w$(__git_ps1 " (%s)")]\$ '
#PS1='[\u@\h \W]\$ '

__git_relative_path ()
{
  if [ "$PWD" == "$HOME" ]
  then
    echo "~"
  else
    if [ "$PWD" == '/' ]
    then
      echo "/"
    else
      TMP1=$(git rev-parse --show-toplevel)
      if [ "$TMP1" == "$HOME" ]
      then
        TMP1='~'
      fi
      TMP2="/$(git rev-parse --show-prefix)"
      echo "${TMP1##*/}${TMP2%\/}"
    fi
  fi
}
__custom_git_PS1 () {
  if ! git rev-parse 2> /dev/null; then
    echo "$PWD"
  else
    echo "$(__git_relative_path)⎇ $(__git_ps1 "%s")"
  fi
}
export -f __git_relative_path
export -f __custom_git_PS1
PS1='$(__custom_git_PS1)$ '

#alias grep='grep --color -P'
alias grep='grep --color'
alias grepr='grep -r'

#alias dmenu="yeganesh -- -fn '-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*' -nb '#000000' -nf '#FFFFFF' -sb '#0066ff'"

export AWS_AUTO_SCALING_HOME=/home/saher/amazon-ec2/AutoScaling-1.0.61.1
export AWS_CREDENTIAL_FILE=/home/saher/.ec2/default-credentials
export AWS_CLOUDWATCH_HOME=/home/saher/amazon-ec2/CloudWatch-1.0.13.4
PATH=$PATH:/home/saher/amazon-ec2/AutoScaling-1.0.61.1/bin
PATH=$PATH:/home/saher/amazon-ec2/CloudWatch-1.0.13.4/bin

source ~/.rake_cap_bash_autocomplete.sh
source ~/.wraith_bash_autocomplete.sh

source ~/.bash_functions


export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH=$PATH:~/.cabal/bin:~/.xmonad/bin
export PATH="$HOME/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
source /home/saher/google-cloud-sdk/path.bash.inc

# The next line enables bash completion for gcloud.
source /home/saher/google-cloud-sdk/completion.bash.inc
