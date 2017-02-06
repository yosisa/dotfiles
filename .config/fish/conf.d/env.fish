function add_path_if_exists
  test -d "$argv[1]"; and set PATH "$argv[1]" $PATH
end

add_path_if_exists "$HOME/.cargo/bin"
add_path_if_exists "$HOME/bin"

if test -z "$SSH_CONNECTION"; and command -v emacsclient >/dev/null
  set -x EDITOR emacsclient
else
  set -x EDITOR vim
end

set -x LESS "-g -i -M -R -S -X -z-4"
