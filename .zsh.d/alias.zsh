if command -v eza >/dev/null; then
    alias ls="eza"
    alias ll="eza -l"
    alias lal="eza -al"
elif command -v gls >/dev/null; then
    alias ls="gls --color"
    alias ll="gls --color -l"
    alias lal="gls --color -Al"
else
    alias ls="ls -G"
    alias ll="ls -Gl"
    alias lal="ls -GAl"
fi

if command -v nvim >/dev/null; then
    alias v="nvim"
    alias vj="nvim -c 'set ft=json'"
    alias vy="nvim -c 'set ft=yaml'"
elif command -v vim >/dev/null; then
    alias v="vim"
    alias vj="vim -c 'set ft=json'"
    alias vy="vim -c 'set ft=yaml'"
fi

command -v gsed >/dev/null && alias sed="gsed"

command -v kubectl >/dev/null && alias k="kubectl"
command -v kubectx >/dev/null && alias kx="kubectx"

command -v docker >/dev/null && alias d="docker"
command -v nerdctl >/dev/null && alias n="nerdctl"

command -v gitui >/dev/null && alias g="gitui"
command -v just >/dev/null && alias j="just"

command -v claude >/dev/null && alias cl="claude"
command -v codex >/dev/null && alias cx="codex"
command -v opencode >/dev/null && alias oc="opencode"

if command -v pi >/dev/null; then
    command -v nono >/dev/null && alias px="nono run --profile always-further/pi --allow-cwd -- pi"
fi
