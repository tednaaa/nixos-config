function docker_cleanup
	docker system prune -a
end

function nix_cleanup
	sudo nix-collect-garbage -d
end

function claude_cleanup
	set -l sessions ~/.claude/projects/*/*.jsonl
	if test (count $sessions) -eq 0
		echo 'No Claude Code sessions found'
		return
	end

	read -l -P "Delete all "(count $sessions)" Claude Code sessions? Type 'yes' to confirm: " answer
	if test "$answer" != yes
		echo Aborted
		return 1
	end

	for session in $sessions
		__claude_session_delete $session
	end
	echo "Deleted "(count $sessions)" sessions"
end

function nvim_cleanup
	rm -rf ~/.local/share/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.cache/nvim
end
