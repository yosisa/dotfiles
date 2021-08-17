if command -v gls > /dev/null; then
    alias ls="gls --color"
else
    alias ls="ls -G"
fi
