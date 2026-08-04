{pkgs, ...}: {
  services.printing.enable = true;

  programs.nano.enable = false;

  # Enable the GNOME Desktop Environment.
  services = {
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
    };
    # GNOME 50+ is Wayland-only; the old `wayland = true` knob is gone
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # current (GNOME 45+) app names — the old ones (cheese/evince/totem/gedit/…)
  # are no longer in the core set and excluding them did nothing
  environment.gnome.excludePackages = with pkgs; [
    baobab # disk
    decibels # audio player (vlc/mpv cover it, like gnome-music before)
    epiphany # web browser
    gnome-characters
    gnome-contacts
    gnome-connections
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-tour
    gnome-console
    gnome-user-docs
    gnome-text-editor
    orca
    papers # document viewer (evince's successor)
    showtime # video player (totem's successor)
    simple-scan
    snapshot # camera (cheese's successor)
    yelp # help viewer
  ];
}
