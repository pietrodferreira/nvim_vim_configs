# apt aliases:
alias apt-i='sudo apt install'; alias apt-r='sudo apt remove'; alias apt-s='apt search';
alias apt-ud='sudo apt update'; alias apt-ug='sudo apt upgrade'; 
alias apt-upd='sudo apt update -y && sudo apt upgrade -y'; alias apt-ar='sudo apt autoremove';
alias apt-sw='apt show'

# apt aliases.

alias cls='clear';
alias die='shutdown now';
alias clip='xclip -selection clipboard';

# c aliases:

function cbuild() {
  gcc -Wall -Wextra -pedantic "$1" -o "${1%.c}"
}

function ccheck() {
  gcc -Wall -Wextra -pedantic -fsyntax-only "$1"
}

function ccheck_werror() {
  gcc \
    -Wall \
    -Wextra \
    -Werror \
    -pedantic-errors \
    -fsyntax-only \
    "$1"
}

# c aliases.


