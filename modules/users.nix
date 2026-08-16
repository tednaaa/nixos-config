{ pkgs, username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    description = "Andranik";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
