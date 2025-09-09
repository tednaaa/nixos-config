function screenshot
	set dir (_ensure_screenshot_dir)
	set filename (date '+%Y%m%d-%H:%M:%S').png
	grim -g "$(slurp -o -r -c '##ff0000ff')" -t ppm - | satty --filename - --output-filename "$dir/$filename"
end

function _ensure_screenshot_dir
	set -l dir ~/Pictures/Screenshots
	if not test -d $dir
		mkdir -p $dir
	end
	echo $dir
end
