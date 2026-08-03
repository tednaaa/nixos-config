fish_add_path ~/.local/bin

set -gx EDITOR "zeditor --wait"
# set -gx EDITOR "nvim"

if status is-interactive
	alias ls="eza --all --icons -l --no-user -o"
	alias fd="fd --hidden"
	alias k="kubectl"
	alias zed="zeditor"

	devenv hook fish | source
	starship init fish | source
	zoxide init fish | source
end
