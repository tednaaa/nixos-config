#### Follow steps from NixOS manual for disk formating

- https://nixos.org/manual/nixos/stable/#sec-installation-manual

#### Then follow my steps ;)

```fish
nixos-generate-config --root /mnt

mkdir -p /mnt/home/{your_user}
cd /mnt/home/{your_user}

git clone .../nixos-config
git clone .../dotfiles

cp /mnt/etc/nixos/hardware-configuration.nix ./nixos-config/hosts/hardware-configuration.nix

nixos-install --flake ./nixos-config#nixos
```

#### Set password for user and reboot

```fish
passwd {your_user}
reboot
```

#### Give to user edit access

```fish
sudo chown -R $USER:users ~/nixos-config
sudo chown -R $USER:users ~/dotfiles
```

#### Update system

```fish
nix flake update
sudo nixos-rebuild boot --flake ~/nixos-config
```
