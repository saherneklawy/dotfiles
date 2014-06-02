#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

#eval $(ssh-agent)
eval $(keychain --eval --agents ssh -Q --quiet id_rsa)
