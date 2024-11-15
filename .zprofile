if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
  export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=y
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
  export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=y
fi

export XDG_CONFIG_HOME=$HOME/.config
export GOPATH=$HOME/go

(( ${+commands[nvim]} )) && export EDITOR=nvim
(( ${+commands[volta]} )) && export VOLTA_HOME=$HOME/.volta

path=(
  $HOME/.local/bin(N/)
  $HOME/.krew/bin(N/)
#  $HOME/.rd/bin(N/)
  $HOME/.cargo/bin(N/)
  $GOPATH/bin(N/)
  $HOME/.volta/bin(N/)
  $HOME/.flutter/bin(N/)
  $HOME/.vector/bin(N/)
  $HOME/google-cloud-sdk/bin(N/)
  /usr/local/opt/grep/libexec/gnubin(N/)
  /usr/local/opt/gnu-sed/libexec/gnubin(N/)
  $path
)

fpath=($HOME/.zsh.d/completions $fpath)

export PIPENV_VENV_IN_PROJECT=1

if command -v colima >/dev/null; then
  export LIMA_INSTANCE=colima
fi

if command -v pspg >/dev/null; then
  export PSQL_PAGER=pspg
  export USQL_PAGER=pspg
  export PSPG="-s 17"
fi

if command -v zk >/dev/null; then
  export ZK_NOTEBOOK_DIR=$HOME/notes
fi
