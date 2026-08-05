{
  pkgs,
  config,
  ...
}: {
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.whitesur-cursors;
      name = "WhiteSur-cursors";
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
