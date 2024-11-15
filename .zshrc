(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Set basic options
setopt notify
setopt autopushd
export HISTSIZE=10000
export SAVEHIST=10000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
export WORDCHARS='*?_-.[]~;!#$%^(){}<>'

# Enable emacs-like key bindings
bindkey -e

# Load powerlevel10k theme
zinit depth"1" light-mode for romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit blockf light-mode for \
      zsh-users/zsh-completions

autoload -Uz compinit; compinit

zinit cdreplay -q

zinit blockf light-mode for Aloxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting

function _my_setup_zsh_history_substring_search {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}

zinit wait lucid light-mode for \
      zdharma-continuum/history-search-multi-word \
      atload"_my_setup_zsh_history_substring_search" zsh-users/zsh-history-substring-search \
      atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions

zinit wait lucid light-mode \
      atload"zpcdreplay" atclone"./zplug.zsh" for \
      g-plane/zsh-yarn-autocompletions

if [[ $(uname) == "Darwin" ]]; then
  zinit wait lucid light-mode for SukkaW/zsh-osx-autoproxy
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=250"

if [[ -d ~/.zsh.d ]]; then
    for f in ~/.zsh.d/*.zsh(.); do
        source $f
    done
fi
