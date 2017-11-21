function open-modified {
  vim `git status -suno | grep M | awk '{print $2}'`
}

function long-phantom {
  if [ -z "$1" ]; then
    ps -eo pid,etime,command  | grep -P "([1-9]\d|0[5-9]):.*[p]hantom.*snap"
  elif [ "$1" == 'all' ]; then
    ps -eo pid,etime,command  | grep -P "[p]hantom.*snap"
  elif [ "$1" == 'kill' ]; then
    kill -9 $(ps -eo pid,etime,command  | grep -P "([1-9]\d|0[5-9]):.*[p]hantom.*snap" | awk '{print $1}')
  else
    echo "USUAGE: long-phantom [all|kill]"
  fi
}

# https://wiki.archlinux.org/index.php/DPMS#Setting_up_DPMS_in_X

function screensaver-off {
  sleep 1
  xset -dpms
  xset s off
}

function screensaver-on {
  sleep 1
  xset +dpms
}

function switch-kops {
  kops export kubecfg --name $NAME --state $KOPS_STATE_STORE
}

export -f open-modified
export -f long-phantom
