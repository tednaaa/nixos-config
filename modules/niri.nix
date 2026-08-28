{
  pkgs,
  lib,
  config,
  ...
}:
let
  niri = lib.getExe config.programs.niri.package;
  regreet = lib.getExe config.services.displayManager.regreet.package;
in
{
  programs = {
    niri.enable = true;
  };

  # options picker
  # `bat $(nix-build --no-out-link '<nixpkgs>' -A xkeyboard_config)/share/X11/xkb/rules/base.lst | fzf`
  services.xserver.xkb = {
    layout = "us,ru";
    options = "ctrl:grouptoggle_capscontrol";
  };
  console.useXkbConfig = lib.mkForce true;

  services = {
    displayManager.regreet = {
      enable = true;
      package = pkgs.symlinkJoin {
        name = "regreet-env";
        inherit (pkgs.regreet) version;
        paths = [ pkgs.regreet ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = "wrapProgram $out/bin/regreet --set GSK_RENDERER cairo --prefix XDG_DATA_DIRS : ${pkgs.glycin-loaders}/share";
        meta.mainProgram = "regreet";
      };
      theme = {
        package = pkgs.colloid-gtk-theme;
        name = "Colloid-Dark";
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      cursorTheme = {
        package = pkgs.apple-cursor;
        name = "macOS";
      };
      font = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
        size = 12;
      };
      settings.background = {
        path = ../home/wallpapers/torii-samurai-sunset.jpg;
        fit = "Cover";
      };
    };

    greetd.settings.default_session.command = "${pkgs.dbus}/bin/dbus-run-session ${niri} --config /etc/greetd/niri.kdl";

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

  environment.etc = {
    "niri/outputs.kdl".source = ../home/niri/outputs.kdl;
    "greetd/niri.kdl".source = pkgs.replaceVars ../home/niri/greeter.kdl { inherit niri regreet; };
  };

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
  ];
}
