{pkgs, config, ... }: 
let 
  keyboardLayout = config.var.keyboardLayout;
in {

  # Enable the GNOME Desktop Environment.
    services.xserver = {
      enable = true;
      xkb.layout = keyboardLayout;
      xkb.variant = "";
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
      excludePackages = [ pkgs.xterm ];
    };

    console.keyMap = keyboardLayout;
  
    environment.gnome.excludePackages = with pkgs; [
      baobab # disk 
      cheese # photo booth
      epiphany # web browser
      evince # document viewer
      file-roller # archive manager
      geary # email client
      gedit # text editor
      gnome-characters
      gnome-contacts
      gnome-connections
      gnome-font-viewer
      gnome-logs
      gnome-maps
      gnome-music
      gnome-photos
      gnome-tour
      gnome-console
      gnome-user-docs
      gnome-text-editor
      orca
      simple-scan
      totem # video player
      yelp # help viewer
      seahorse # password manager
    ];
}
