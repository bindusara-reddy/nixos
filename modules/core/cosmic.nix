{...}: {
  # COSMIC (System76's Rust DE) — the only session; cosmic-greeter
  # replaces GDM at login.
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # kept from the old gnome.nix (not GNOME-specific)
  services.printing.enable = true;
  programs.nano.enable = false;
}
