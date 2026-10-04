function __claude_sessions_tsv
	for session in ~/.claude/projects/*/*.jsonl
		jq -rs --arg file $session '
			([.[] | select(.cwd)][0]) as $first
			| select($first)
			| [
				$first.cwd,
				($first.timestamp[0:16] | sub("T"; " ")),
				(
					([.[] | .customTitle // empty] | last) as $custom
					| ([.[] | .aiTitle // empty] | last) as $ai
					| ([.[] | .lastPrompt // empty] | last) as $prompt
					| [$custom, $ai] | map(select(.)) | if $custom == $ai then .[:1] end
					| if length > 0 then join(" · ") else $prompt // "untitled" end
					| gsub("[[:space:]]+"; " ")
				),
				$first.sessionId,
				$file
			]
			| @tsv
		' $session
	end
end

function __claude_sessions_newest_first
	__claude_sessions_tsv | sort -t \t -k 2 -r
end

function __claude_session_preview --argument-names file
	jq -r 'select(.type == "user" and (.message.content | type) == "string") | "> " + .message.content + "\n"' $file
end

function __claude_session_delete --argument-names file
	rm -rf $file (string replace -r '\.jsonl$' '' $file)
end

function claude --wraps claude --description 'Run Claude Code, then hint at claude_pick for session cleanup'
	set -l started (date +%s)
	command claude $argv
	set -l exit_status $status

	set -l project ~/.claude/projects/(string replace -ra '[^a-zA-Z0-9]' '-' $PWD)
	set -l session (command ls -t $project/*.jsonl 2>/dev/null)[1]
	if test -n "$session"; and test (path mtime $session) -ge $started
		echo
		set_color --dim
		echo "Run claude_pick to clean up sessions (ctrl-d deletes)"
		set_color normal
	end

	return $exit_status
end

function claude_sessions --description 'Write all Claude Code sessions, grouped by project, to a markdown file'
	set -l out ~/.cache/claude-sessions.md
	set -q argv[1]; and set out $argv[1]

	__claude_sessions_tsv | sort | awk -F '\t' '
		$1 != project { if (NR > 1) print ""; project = $1; print "## " project; print "" }
		{ print "- " $2 " — " $3 " — `" $4 "`" }
	' >$out

	set_color --dim
	echo $EDITOR $out
	set_color normal
end

function claude_pick --description 'Pick a Claude Code session to resume (enter) or delete (ctrl-d)'
	set -l pick (__claude_sessions_newest_first | fzf \
		--delimiter \t \
		--with-nth 2,3,1 \
		--with-shell 'fish -c' \
		--header 'enter resume · ctrl-d delete' \
		--preview '__claude_session_preview {5}' \
		--preview-window 'right,50%,wrap' \
		--bind 'ctrl-d:execute-silent(__claude_session_delete {5})+reload(__claude_sessions_newest_first)')
	or return

	set -l fields (string split \t -- $pick)
	cd $fields[1]; and claude --resume $fields[4]
end
