export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

_rakecomplete() {
  if [ -f "$PWD/.rake_commands" ]
  then
      export RAKE_CACHE=`cat "$PWD/.rake_commands"`
  fi
  if [ ! "$RAKE_CACHE" ]
  then
      export RAKE_CACHE=`rake -s -T 2>/dev/null | awk '{{print $2}}'`
      echo $RAKE_CACHE > "$PWD/.rake_commands"
  fi
  COMPREPLY=($(compgen -W "$RAKE_CACHE" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

_capcomplete() {
  if [ -f "$PWD/.capistrano_commands" ]
  then
      export CAPISTRANO_CACHE=`cat "$PWD/.capistrano_commands"`
  fi
  if [ ! "$CAPISTRANO_CACHE" ]
  then
      export CAPISTRANO_CACHE=`cap  -T  2>/dev/null| awk '{{ if ( $3 ~ /\#/ ) print $2}}'`
      echo $CAPISTRANO_CACHE > "$PWD/.capistrano_commands"
  fi
  COMPREPLY=($(compgen -W "$CAPISTRANO_CACHE" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

_thorcomplete() {
  COMPREPLY=($(compgen -W "`THOR_COLUMNS=1000 thor -T 2>/dev/null| awk '{{ if ( $2 ~ /./ ) print $2}}'`" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

complete -o default -o nospace -F _rakecomplete rake
complete -o default -o nospace -F _capcomplete cap
complete -o default -o nospace -F _thorcomplete thor
