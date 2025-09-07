{ pkgs, ... }: {
  users.users.tedna = {
    isNormalUser = true;
    description = "Andranik";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
