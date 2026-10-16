{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  home.packages = with pkgs; [
    sops
    age
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets.ssh_config = {
      sopsFile = ./secrets/ssh_config;
      format = "binary";
      path = "${config.home.homeDirectory}/.ssh/config";
    };
  };
}
