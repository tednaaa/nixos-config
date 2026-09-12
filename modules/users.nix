{ pkgs, username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    description = "Andranik";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "input"
      "uinput"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
