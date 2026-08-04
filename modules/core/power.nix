{
  # power profiles in the GNOME quick-settings menu + Intel thermal management
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;

  # firmware updates: `fwupdmgr refresh && fwupdmgr update`
  services.fwupd.enable = true;

  # compressed swap in RAM — keeps heavy rust builds + browser tabs alive
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };
}
