if status is-interactive
	# Commands to run in interactive sessions can go here
end

alias ls="eza --all --icons -l --no-user -o"

set -gx EDITOR "zeditor --wait"

source ~/.config/fish/functions/*.fish

source ~/.cargo/env.fish
mise activate fish | source
starship init fish | source
zoxide init fish | source
