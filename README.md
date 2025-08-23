```fish
cd ~/nixos-config
nixos-rebuild switch --flake ~/nixos-config#nixos
```

```fish
nix flake update; nixos-rebuild switch --flake ~/nixos-config#nixos
```
