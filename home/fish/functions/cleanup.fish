function docker_cleanup
	docker system prune -a
end

function nix_cleanup
	sudo nix-collect-garbage -d
end

function nvim_cleanup
	rm -rf ~/.local/share/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.cache/nvim
end
