# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# zinit light zsh-users/zsh-syntax-highlighting
zinit blockf light-mode for \
      zsh-users/zsh-completions

autoload -Uz compinit; compinit

zinit cdreplay -q

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting

function _my_setup_zsh_history_substring_search {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}

zinit wait lucid light-mode for \
      zdharma/history-search-multi-word \
      atload"_my_setup_zsh_history_substring_search" zsh-users/zsh-history-substring-search \
      atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions

zinit wait lucid as"command" from"gh-r" \
      mv"zoxide*/zoxide -> zoxide" \
      atclone"./zoxide init zsh > init.zsh" \
      atpull"%atclone" pick"zoxide" src"init.zsh" nocompile"!" \
      light-mode for ajeetdsouza/zoxide

zinit wait lucid as"program" from"gh-r" \
      mv"direnv* -> direnv" \
      atclone"./direnv hook zsh > zhook.zsh" \
      atpull"%atclone" pick"direnv" src"zhook.zsh" \
      light-mode for direnv/direnv

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=250"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ -d ~/.zsh.d ]]; then
    for f in ~/.zsh.d/*.zsh(.); do
        source $f
    done
fi
