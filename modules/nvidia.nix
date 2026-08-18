{ config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    # 595.x (stable/production) has a known Xid 109 "CTX SWITCH TIMEOUT"
    # regression under Vulkan/Proton load -- observed crashing GoWR.exe in
    # journalctl -k on this machine. 610 (latest) is Xid-clean; keep it pinned
    # until 595's successor stable ships the fix.
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
