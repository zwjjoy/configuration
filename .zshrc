# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# pyenv init
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export VIRTUAL_ENV_DISABLE_PROMPT=1

# nvm & nodejs
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/Users/zwjjoy/.bun/_bun" ] && source "/Users/zwjjoy/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# aws init
function ecr-login() {
  export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
  export AWS_REGION=$(aws configure get region)
  export REPO_URI=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

  aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $REPO_URI
}

# aws kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# powerlevel10k init
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# go
export PATH="/opt/homebrew/bin:$PATH"
