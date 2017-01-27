function _git_root
  set -l git_root $PWD
  while test $git_root != '' -a ! -e "$git_root"/.git
    set git_root (string split -r -m1 / $git_root)[1]
  end
  echo $git_root
end

function _git_branch
  echo (string split -r -m1 / (git symbolic-ref HEAD ^/dev/null))[2]
end

function _git_status
  set -l git_status (git status --porcelain)
  if test -n "$git_status"
    echo '*'
  else
    echo ''
  end
end

function _ssh_host
  if test -n "$SSH_CONNECTION"
    echo (set_color -b cyan)(set_color black) SSH (set_color normal)(set_color yellow)$USER@(hostname)' '
  else
    echo
  end
end

function _exit_code
  if test $argv[1] -ne 0
    echo (set_color -o red)EXIT:$argv[1](set_color normal)' '
  else
    echo
  end
end

function _marker
  if test (id -u) -eq 0
    echo '#'
  else
    echo '❯❯'
  end
end

function _pwd
  if test -n $argv[1]
    set -l path (string sub -s (string length $argv[1]) "$PWD")
    set path (string sub -s 3 $path)
    set -l repo (string split -r -m1 / $argv[1])[2]
    echo (set_color cyan)$repo:(_git_branch)(_git_status):(set_color $fish_color_cwd)/$path
  else
    echo (set_color $fish_color_cwd)(prompt_pwd)
  end
end

function fish_prompt
  set -l exit_code $status
  set -l normal (set_color normal)
  set -l cwd (set_color $fish_color_cwd)(_pwd (_git_root))

  echo -n (_ssh_host)(_exit_code $exit_code)$cwd$normal (_marker)' '
end
