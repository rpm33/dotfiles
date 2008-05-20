fpath=(~/.zsh/functions $fpath)
autoload -U compinit promptinit
compinit
promptinit; prompt gentoo
zstyle ':completion::complete:*' use-cache 1
bindkey -e
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt AUTO_PARAM_SLASH
stty stop undef

function chpwd() { ls }

alias perldoc="LC_ALL=C perldoc"
