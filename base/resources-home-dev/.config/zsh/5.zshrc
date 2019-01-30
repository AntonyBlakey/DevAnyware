####### ZGEN

source $HOME/.zgen/zgen.zsh

if ! zgen saved; then
    zgen oh-my-zsh
    zgen load stanleysq/aplos aplos
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/command-not-found
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zlsun/solarized-man
    zgen save
fi

######## Prompt

prompt_host="%{$fg[blue]%}$PROMPT_NAME$(hostname)%{$reset_color%}"
prompt_dir="%{$fg_bold[blue]%}%2~%{$reset_color%}"
prompt_user="%{$fg[yellow]%}$(whoami)%{$reset_color%}"
prompt_time="%{$fg[yellow]%}%D{%R:%S}%{$reset_color%}"

PROMPT='
$prompt_user $prompt_host $prompt_dir $prompt_exit_code
$prompt_time ==> '

######## FZF

# This is added ~/.zshrc by the fzf installer
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,node_modules}/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
function edit_in_vim () { vim $(fzf) }
zle -N edit_in_vim_widget edit_in_vim
bindkey "^P" edit_in_vim_widget

######## vim

export VISUAL=nvim
alias vi=nvim
alias vim=nvim

######## local binaries

export path=($HOME/.local/bin $path)