# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it is not there yet
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi

# Source/Load Zinit.sh
source "${ZINIT_HOME}/zinit.zsh"

# Load oh-my-posh with custom config
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

## Zinit plugins
# Syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

# Autocompletions
zinit light zsh-users/zsh-completions

# Autosuggestions
zinit light zsh-users/zsh-autosuggestions

# Fuzzy finding tabcompletion
zinit light Aloxaf/fzf-tab

# Add snippets
# git
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Shell integrations
# eval "$(fzf --zsh)" # fzf 0.48.0 or later
# Below required on ubuntu, similar to the command above
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
# eval "$(fzf)" # fzf 0.47.0 or earlier
eval "$(zoxide init --cmd cd zsh)"

#setxkbmap -model 'pc104' \
#  -layout 'us(cmk_ed_us)' \
#  -option 'misc:extend,caps:swapescape,grp:shifts_toggle,compose:menu,misc:cmk_curl_dh'
setxkbmap -option "caps:swapescape"
