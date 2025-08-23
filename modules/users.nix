{ pkgs, ... }:
{
  users.users.tedna = {
    isNormalUser = true;
    description = "Andranik";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  programs.fish.interactiveShellInit = "";

  programs.firefox.enable = true;
}
