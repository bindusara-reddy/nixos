{
  pkgs,
  config,
  ...
}: {
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    theme = {
      package = pkgs.whitesur-gtk-theme;
      name = "WhiteSur-Dark-solid";
    };
    iconTheme = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur-dark";
    };
    # newer home-manager stops theming GTK4 apps unless told; keep WhiteSur everywhere
    gtk4.theme = config.gtk.theme;
  };
}
