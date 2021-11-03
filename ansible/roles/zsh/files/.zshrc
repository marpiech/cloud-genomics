# HISTORY
HISTFILE="$HOME/.history"
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/marpiech/.sdkman"
[[ -s "/home/marpiech/.sdkman/bin/sdkman-init.sh" ]] && source "/home/marpiech/.sdkman/bin/sdkman-init.sh"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ALIASES
alias ls='ls --color'
alias kubepgx='kubectl --kubeconfig /home/marpiech/config/labpgx.yml'
#kubepgx kubectl get svc --namespace default -w apache-release **
