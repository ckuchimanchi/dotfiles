
# Keep oodles of command history (see https://fburl.com/zshhistory).
HISTSIZE=1000000
SAVEHIST=1000000
setopt APPEND_HISTORY

# Allow tab completion in the middle of a word.
setopt COMPLETE_IN_WORD

export FZF_PATH="$HOME/.fzf"
export REMOTECOPY_PATH="$HOME/.remotecopy"

#FZF RELATED variables 
# export FZF_DEFAULT_COMMAND='fd --type f '
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --inline-info'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

export EDITOR=vim
export TMUX_OPTIONS="-CC"
