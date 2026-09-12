function appimage_install -a file
	if test -z "$file"; or not test -f "$file"
		echo (set_color red)"usage: appimage_install <path-to.AppImage>"(set_color normal) >&2
		return 1
	end

	set -l target ~/apps/(path basename $file)
	set -l slug (_appimage_slug $file)

	mkdir -p ~/apps
	if test (path resolve $file) != (path resolve $target)
		mv $file $target
	end
	chmod +x $target

	set -l extract_dir ~/.cache/appimage-install/$slug
	rm -rf $extract_dir
	mkdir -p (path dirname $extract_dir)

	if not appimage-run -x $extract_dir $target >/dev/null
		echo (set_color red)"cannot extract "(path basename $target)(set_color normal) >&2
		return 1
	end

	set -l source (find $extract_dir -maxdepth 1 -name '*.desktop' | head -1)
	if test -z "$source"
		echo (set_color red)"no .desktop inside "(path basename $target)(set_color normal) >&2
		rm -rf $extract_dir
		return 1
	end

	_appimage_write_entry $source $slug $target (_appimage_install_icon $source $slug $extract_dir)
	rm -rf $extract_dir

	if command -q update-desktop-database
		update-desktop-database ~/.local/share/applications
	end

	echo (set_color green)"installed "(set_color -o cyan)$slug(set_color normal)
end

function appimage_list
	set -l entries (find ~/.local/share/applications -maxdepth 1 -name 'appimage-*.desktop' 2>/dev/null | sort)

	if test -z "$entries"
		echo (set_color yellow)"no appimages installed"(set_color normal)
		return 1
	end

	echo
	for entry in $entries
		set -l slug (_appimage_entry_slug $entry)
		set -l path (_appimage_field $entry X-AppImage-Path)

		printf '  %s%-24s %s%s%s\n' \
			(set_color -o cyan) $slug \
			(set_color brblack) (string replace $HOME '~' $path) \
			(set_color normal)
	end
	echo
end

function appimage_remove -a slug
	set -l entry ~/.local/share/applications/appimage-$slug.desktop

	if not test -f $entry
		echo (set_color red)"no appimage named $slug"(set_color normal) >&2
		appimage_list
		return 1
	end

	set -l target (_appimage_field $entry X-AppImage-Path)
	if test -f "$target"
		rm -rf ~/.cache/appimage-run/(string split ' ' -f1 (sha256sum $target))
		rm $target
	end

	find ~/.local/share/icons/hicolor -name "appimage-$slug.*" -delete 2>/dev/null
	rm $entry

	if command -q update-desktop-database
		update-desktop-database ~/.local/share/applications
	end

	echo (set_color green)"removed "(set_color -o cyan)$slug(set_color normal)
end

function _appimage_slug -a file
	string lower (path change-extension '' (path basename $file)) \
		| string replace -ra '[^a-z0-9]+' '-' \
		| string trim -c -
end

function _appimage_entry_slug -a entry
	string replace -r '^appimage-' '' (path change-extension '' (path basename $entry))
end

function _appimage_field -a entry field
	string replace -r "^$field=" '' (grep -m1 "^$field=" $entry)
end

function _appimage_install_icon -a source slug dir
	set -l name (_appimage_field $source Icon)
	test -z "$name"; and return

	set -l found
	for size in scalable 512x512 256x256 128x128 64x64 48x48
		set found (find $dir \( -path "*/$size/apps/$name.svg" -o -path "*/$size/apps/$name.png" \) | head -1)
		test -n "$found"; and break
	end
	test -z "$found"; and set found (find $dir -maxdepth 1 -name "$name.*" | head -1)
	test -z "$found"; and return

	set -l ext (path extension $found)
	set -l size 256x256
	test "$ext" = .svg; and set size scalable
	set -l matched (string match -r '/(\d+x\d+)/apps/' $found)
	test -n "$matched"; and set size $matched[2]

	set -l dest ~/.local/share/icons/hicolor/$size/apps/appimage-$slug$ext
	mkdir -p (path dirname $dest)
	cp -Lf $found $dest
	echo appimage-$slug
end

function _appimage_write_entry -a source slug target icon
	set -l dest ~/.local/share/applications/appimage-$slug.desktop
	set -l exec_args (string split -m1 ' ' -f2 (_appimage_field $source Exec))
	set -l terminal (_appimage_field $source Terminal)
	test -z "$terminal"; and set terminal false

	mkdir -p (path dirname $dest)

	begin
		echo "[Desktop Entry]"
		echo "Type=Application"
		echo "Name="(_appimage_field $source Name)
		echo "Exec=appimage-run $target $exec_args"
		test -n "$icon"; and echo "Icon=$icon"
		echo "Terminal=$terminal"

		for field in GenericName Comment Categories MimeType StartupWMClass StartupNotify
			set -l value (_appimage_field $source $field)
			test -n "$value"; and echo "$field=$value"
		end

		echo "X-AppImage-Path=$target"
	end >$dest
end
