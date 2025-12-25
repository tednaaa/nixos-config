function nix_update
	sudo nixos-rebuild boot --flake ~/nixos-config
end

function nix_cleanup
	sudo nix-collect-garbage -d
end

function nix_generations
	nixos-rebuild list-generations
end
