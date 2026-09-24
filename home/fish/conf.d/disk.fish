# usage:
# check_heavy_path /
# check_heavy_path ~/.local/share

function check_heavy_path
	dust $argv -d 2 -n 50 -z 1G
end
