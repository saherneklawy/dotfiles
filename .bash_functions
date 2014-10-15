function open_modified {
  vim `git status -suno | grep M | awk '{print $2}'`
}

export -f open_modified
