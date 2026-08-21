function show_shonk_ui_projects
	set -l filter '
		(.dependencies + .devDependencies + .peerDependencies)
		| .["shonk-ui"] // empty
		| "\(input_filename)\t\(.)"
	'

	set -l rows (fd -t f -g package.json ~ -E node_modules -E '.*' -X jq -r $filter | sort)

	if test -z "$rows"
		echo (set_color yellow)"no projects use shonk-ui"(set_color normal)
		return 1
	end

	echo
	echo "  "(set_color -o cyan)shonk-ui(set_color normal)(set_color brblack)" · "(count $rows)" projects"(set_color normal)
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
