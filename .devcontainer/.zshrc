if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HOME='/home/vscode'

source $HOME/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle terraform
antigen bundle command-not-found

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme romkatv/powerlevel10k

antigen apply

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

alias ls='lsd'
alias l='ls -l'
alias ll='ls -lh'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh