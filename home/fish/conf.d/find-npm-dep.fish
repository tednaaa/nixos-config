function find_npm_dep -a dep
	if test -z "$dep"
		echo (set_color red)"usage: find_npm_dep <package>"(set_color normal) >&2
		return 1
	end

	set -l filter '
		(.dependencies + .devDependencies + .peerDependencies)
		| .[$dep] // empty
		| "\(input_filename)\t\(.)"
	'

	set -l rows (fd -t f -g package.json ~ --no-ignore-vcs -E dist -E '.*' -X jq -r --arg dep $dep $filter | sort)

	if test -z "$rows"
		echo (set_color yellow)"no projects use $dep"(set_color normal)
		return 1
	end

	echo
	echo "  "(set_color -o cyan)$dep(set_color normal)(set_color brblack)" · "(count $rows)" projects"(set_color normal)
	echo

	for row in $rows
		set -l cols (string split \t $row)
		set -l dir (string replace $HOME '~' (path dirname $cols[1]))

		printf '  %s%-8s %s%s/%s%s%s\n' \
			(set_color green) $cols[2] \
			(set_color brblack) (path dirname $dir) \
			(set_color white) (path basename $dir) \
			(set_color normal)
	end
	echo
end
