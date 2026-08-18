{
  config,
  pkgs,
  inputs,
  username,
  ...
}:
{
  system.stateVersion = "26.05";

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    trusted-users = [
      "root"
      username
    ];
  };

  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  boot.kernelPackages = pkgs.linuxPackages;
  boot.loader = {
    limine.enable = true;
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Asia/Yerevan";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.graphics.enable = true;
  hardware.nvidia.open = true;
  # 595.x (stable/production) has a known Xid 109 "CTX SWITCH TIMEOUT"
  # regression under Vulkan/Proton load -- observed crashing GoWR.exe in
  # journalctl -k on this machine. 610 (latest) is Xid-clean; keep it pinned
  # until 595's successor stable ships the fix.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;

  nixpkgs.config.allowUnfree = true;
}
