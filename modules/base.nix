{ config, pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Yerevan";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  environment.systemPackages = with pkgs; [
    zed-editor neovim alacritty starship btop ripgrep zoxide eza fd bat yazi
    resvg fzf jq git delta lazygit tabiew netcat-openbsd openssh rsync bind cmake nixd

    telegram-desktop
  ];

  nixpkgs.config.allowUnfree = true;
}
