#!/usr/bin/env fish

set -l extensions_dir "$HOME/.local/share/zed/extensions/installed"

if not test -d "$extensions_dir"
	echo "error: $extensions_dir does not exist" >&2
	exit 1
end

set -l extensions
for dir in "$extensions_dir"/*/
	test -d "$dir"; or continue
	set -a extensions (basename "$dir")
end

if test (count $extensions) -eq 0
	echo "error: no extensions found in $extensions_dir" >&2
	exit 1
end

set extensions (printf '%s\n' $extensions | sort)

set -l block (printf '%s\n' $extensions | jq -R . | jq -s 'reduce .[] as $name ({}; .[$name] = true)')

printf '"auto_install_extensions": %s\n' $block[1]
for line in $block[2..-2]
	echo $line
end
printf '%s,\n' $block[-1]
