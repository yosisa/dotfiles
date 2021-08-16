alias df "df -h"
alias en "emacsclient -n"

if command -v colordiff >/dev/null
  alias diff "colordiff -u"
else
  alias diff "diff -u"
end

if command -v bat >/dev/null
  alias b bat
  alias by "bat -l yaml"
  alias bj "bat -l json"
end

if command -v pet >/dev/null
  alias p pet-select
end
