### Fresh Install

```fish
nixos-generate-config --root /mnt

cd /mnt/home

git clone .../dotfiles
git clone .../nixos-config

cp /mnt/etc/nixos/hardware-configuration.nix ./nixos-config/hosts/hardware-configuration.nix

nixos-install --flake ./nixos-config
```

### Update system

```fish
nix flake update; sudo nixos-rebuild switch --flake ~/nixos-config
```
