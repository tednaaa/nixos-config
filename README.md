### Fresh Install

```fish
cd /mnt/home

git clone .../dotfiles
git clone .../nixos-config

sudo nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix ./hosts/hardware-configuration.nix

sudo nixos-install --flake .
```

### Update system

```fish
nix flake update; sudo nixos-rebuild switch --flake ~/nixos-config
```
