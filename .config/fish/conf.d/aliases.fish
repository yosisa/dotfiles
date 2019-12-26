alias df "df -h"
alias en "emacsclient -n"

if command -v colordiff >/dev/null
  alias diff "colordiff -u"
else
  alias diff "diff -u"
end

if command -v bat >/dev/null
  alias b bat
end
