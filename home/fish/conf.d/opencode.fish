function opencode --wraps opencode
	if string match -q "$HOME/work/*" "$PWD/"
		OPENCODE_CONFIG="$HOME/work/opencode.jsonc" command opencode $argv
	else
		command opencode $argv
	end
end
