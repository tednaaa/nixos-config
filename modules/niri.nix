{
  pkgs,
  lib,
  ...
}:
{
  programs = {
    niri.enable = true;

    regreet = {
      enable = true;
      settings = {
        background = {
          path = ../home/wallpapers/seaside-pier-sunset.jpg;
          fit = "Cover";
        };
        GTK.application_prefer_dark_theme = true;
      };
    };
  };

  # options picker
  # `bat $(nix-build --no-out-link '<nixpkgs>' -A xkeyboard_config)/share/X11/xkb/rules/base.lst | fzf`
  services.xserver.xkb = {
    layout = "us,ru";
    options = "ctrl:grouptoggle_capscontrol";
  };
  console.useXkbConfig = lib.mkForce true;

  services = {
    greetd.settings.default_session.command = "${pkgs.dbus}/bin/dbus-run-session ${lib.getExe pkgs.niri} -c ${
      pkgs.replaceVars ../home/niri/greeter.kdl {
        outputs = ../home/niri/outputs.kdl;
        niri = lib.getExe pkgs.niri;
        regreet = lib.getExe pkgs.regreet;
      }
    }";

    gnome.gnome-keyring.enable = true;
    power-profiles-daemon.enable = true;
    gvfs.enable = true;
  };

  security = {
    polkit.enable = true;
    pam.services.swaylock = { };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # https://wiki.nixos.org/wiki/Wayland#Electron_and_Chromium
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    fuzzel
    waybar

    swaylock
    swaybg
    swaynotificationcenter

    pulseaudio # for pactl, used by waybar
    pavucontrol
    brightnessctl
    libnotify

    satty
    grim
    slurp

    mpv
    clipse
    wl-clipboard
    wl-clip-persist
    bluetui
    p7zip
    nautilus
    loupe
  ];
}
