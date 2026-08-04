{
  services = {
    # power profiles in the GNOME quick-settings menu + Intel thermal management
    power-profiles-daemon.enable = true;
    thermald.enable = true;

    # firmware updates: `fwupdmgr refresh && fwupdmgr update`
    fwupd.enable = true;
  };

  # compressed swap in RAM — keeps heavy rust builds + browser tabs alive
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # disk fallback behind zram (zram has higher priority, so it fills first) —
  # without this, RAM + zram exhaustion has nowhere to go but the OOM killer.
  # Lives here, not hardware-configuration.nix: bootstrap.sh overwrites that file.
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024; # MiB
    }
  ];
}
