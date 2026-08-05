{pkgs, ...}: {
  # COSMIC (System76's Rust DE) — the only session; cosmic-greeter
  # replaces GDM at login.
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # stock COSMIC apps replaced by better ones already installed:
  # terminal → wezterm, player → vlc, reader → firefox handles pdfs,
  # store → apps come from this repo on NixOS anyway
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-term
    cosmic-store
    cosmic-player
    cosmic-reader
  ];

  # kept from the old gnome.nix (not GNOME-specific)
  services.printing.enable = true;
  programs.nano.enable = false;
}
