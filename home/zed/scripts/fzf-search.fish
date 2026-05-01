#!/usr/bin/fish

set -l reload_cmd '
	set -l q {q}
	if test -n "$q"
		set -l fuzzy_pattern (string replace -a " " ".*" "$q")
		rg -i --hidden --no-heading --line-number --color=always "$fuzzy_pattern"
	else
		printf ""
	end
'

set -l preview_cmd '
	set -l file {1}
	set -l line {2}
	set -l q {q}

	if test -z "$file" -o "$file" = ""
		echo "Start typing to search..."
		exit 0
	end

	set -l start (math "max(1, $line-10)")
	set -l end (math $line+10)
	if test -n "$q"
		set -l fuzzy_pattern (string replace -a " " ".*" "$q")
		bat --color=always --style=plain --line-range "$start":"$end" "$file" \
		| rg -i --color=always --colors "match:bg:yellow" --colors "match:fg:black" --passthru -- "$fuzzy_pattern"
	else
		bat --color=always --style=plain --line-range "$start":"$end" "$file"
	end
'

set -l match (
	printf "" | fzf --ansi --disabled --prompt 'fuzzy rg> ' \
		--delimiter : --nth=3.. \
		--bind "change:reload:$reload_cmd" \
		--preview "$preview_cmd" \
		--preview-window=down:wrap:70%
)

if test -n "$match"
	set -l file (echo $match | cut -d: -f1)
	set -l line (echo $match | cut -d: -f2)
	zed "$file:$line"
end
