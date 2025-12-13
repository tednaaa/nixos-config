{ pkgs, username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    description = "Andranik";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
