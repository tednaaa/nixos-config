### Fresh Install

```fish
nixos-generate-config --root /mnt

cd /mnt/home

git clone .../dotfiles
git clone .../nixos-config

cp /mnt/etc/nixos/hardware-configuration.nix ./nixos-config/hosts/hardware-configuration.nix

nixos-install --flake ./nixos-config#nixos
```

### Update system, inside `~/nixos-config`

```fish
nix flake update; sudo nixos-rebuild boot --flake .
```

also

```fish
sudo nixos-rebuild switch --flake .
```
