{ pkgs, ... }: {
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  gtk = {
    enable = true;

    theme = {
      name = "Orchis-Dark";
      package = pkgs.orchis-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "macOS";
      package = pkgs.apple-cursor;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Orchis-Dark";
      icon-theme = "Papirus-Dark";
      cursor-theme = "macOS";
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Orchis-Dark";
  };
}
