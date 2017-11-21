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

export SSH_AGENT_PID=$(ps -eo pid,command | grep [s]sh-agent | head -n1 | awk '{print $1}')
if [ ! $SSH_AGENT_PID ]; then
  eval `ssh-agent -s`
else
  export export SSH_AUTH_SOCK=$(find /tmp/ssh-* -iname "agent.$((SSH_AGENT_PID-1))")
fi
ssh-add

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
#source ~/.bash_profile

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
__ps1_path () {
  if ! git rev-parse 2> /dev/null; then
    echo -n "$PWD"
  else
    echo -e -n "$(__git_relative_path)⎇ "
  fi
}
__custom_git_PS1 () {
  if git rev-parse 2> /dev/null; then
    echo -e -n "$(__git_ps1 "%s")"
  fi
}

export -f __git_relative_path
export -f __custom_git_PS1
export -f __ps1_path
PS1='$(__ps1_path)\[\e[1;103m\]$(__custom_git_PS1)\[\e[m\]$ '

#alias grep='grep --color -P'
alias grep='grep --color'
alias grepr='grep -r'
alias less='less -R'

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
#source /home/saher/google-cloud-sdk/path.bash.inc

# The next line enables bash completion for gcloud.
#source /home/saher/google-cloud-sdk/completion.bash.inc

export PYTHONSTARTUP=~/.pythonrc

if [ "$TERM" == "xterm" ]; then
    # No it isn't, it's gnome-terminal
    export TERM=xterm-256color
fi

alias say='echo "$1" | espeak -s 120 2>/dev/null'
alias pacuar=pacaur
alias open=xdg-open

alias xradnr=xrandr

export JAVA_HOME=/usr/lib/jvm/default/
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

alias handbrake=ghb
alias mkv-tools=mmg

shopt -s checkwinsize

. /etc/profile.d/vte.sh

export DOCKER_HOST="tcp://0.0.0.0:4243"
export DOCKER_TMPDIR=/mnt/docker/tmp
export VIMRUNTIME=

export ANDROID_HOME=/mnt/apps/android-sdk-linux/
export PATH=$PATH:$ANDROID_HOME/tools

alias fig=docker-compose
alias jdownloader=JDownloader

export SPARK_HOME=/home/saher/workspace/spark/spark-talk/vms

alias ll='ls -lhtr'

export SAL_USE_VCLPLUGIN=gen lowriter


shopt -s checkwinsize

#alias cp="rsync -avP"
alias cp="rsync -a -v --delete --progress --links --stats --human-readable"


export PROJECT_DIR=/home/saher/workspace/bulk-whiz
complete -F _docker_compose fig

export GOPATH=$HOME/workspace/go
export PATH=$GOPATH/bin:$PATH

#export ANSIBLE_INVENTORY=~/ansible_hosts

export PATH=$PATH:/mnt/apps/carrot2-workbench-3.15.0/

source <(kubectl completion bash) # setup autocomplete in bash, bash-completion package should be installed first.
source /usr/share/autoenv/activate.sh

export PATH=$PATH:/home/saher/.gem/ruby/2.4.0/bin
