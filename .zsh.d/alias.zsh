if command -v exa >/dev/null; then
    alias ls="exa"
    alias ll="exa -l"
elif command -v gls >/dev/null; then
    alias ls="gls --color"
    alias ll="gls --color -l"
else
    alias ls="ls -G"
    alias ll="ls -Gl"
fi

if command -v nvim >/dev/null; then
    alias v="nvim"
elif command -v vim >/dev/null; then
    alias v="vim"
fi

command -v kubectl >/dev/null && alias -g k="kubectl"
command -v kubectx >/dev/null && alias kx="kubectx"

command -v docker >/dev/null && alias d="docker"
command -v nerdctl >/dev/null && alias n="nerdctl"
