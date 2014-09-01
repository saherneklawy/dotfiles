#more on http://fahdshariff.blogspot.com/2011/04/writing-your-own-bash-completion.html

_wraithcomplete() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local prev=${COMP_WORDS[COMP_CWORD-1]}
  local words=`wraith | awk '{print $2}'`
  if [[ $COMP_CWORD == 3 ]]
  then
    return 0
  fi
  if [[ $prev && $words == *$prev* ]]
  then
    COMPREPLY=( $(compgen -W "$(ls configs/  | sed 's/.yaml//')" -- $cur) )
  else
    COMPREPLY=( $(compgen -W "$words" -- $cur) )
  fi
}

complete -F _wraithcomplete wraith
