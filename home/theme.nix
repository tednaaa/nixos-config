{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 24;
  };

  gtk = {
    enable = true;

    # theme = {
    #   package = pkgs.orchis-theme;
    #   name = "Orchis-Dark";
    # };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      name = "Noto Sans Medium";
      size = 11;
    };
  };
}
