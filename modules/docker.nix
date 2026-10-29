{ pkgs, lib, ... }:
{
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  systemd.user.services.docker.unitConfig.ConditionUser = lib.mkForce "!@system";

  environment.systemPackages = with pkgs; [
    docker-buildx
    docker-compose
    lazydocker
  ];
}
