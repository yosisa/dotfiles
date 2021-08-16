function add_path_if_exists
  test -d "$argv[1]"; and set PATH "$argv[1]" $PATH
end

function append_path_if_exists
    test -d "$argv[1]"; and set PATH $PATH "$argv[1]"
end

add_path_if_exists "/usr/local/sbin"
add_path_if_exists "$HOME/go/bin"
add_path_if_exists "$HOME/.cargo/bin"
add_path_if_exists "$HOME/.pub-cache/bin"
add_path_if_exists "$HOME/bin"
add_path_if_exists "$HOME/.local/bin"
add_path_if_exists "$HOME/.vector/bin"

append_path_if_exists "$HOME/Library/Android/sdk/platform-tools"

set -x LANG ja_JP.UTF-8

set -x EDITOR vim
if test -z "$SSH_CONNECTION"
  if command -v code >/dev/null
    set -x EDITOR 'code -w'
  else if command -v emacsclient >/dev/null
    set -x EDITOR emacsclient
  end
end

set -x LESS "-g -i -M -R -S -X -z-4"
set -x GOPATH "$HOME/go"

if command -v direnv >/dev/null
  eval (direnv hook fish)
end
