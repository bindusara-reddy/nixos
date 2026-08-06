{config, ...}: {
  networking = {
    hostName = "${config.var.hostname}";
    networkmanager.enable = true;
  };

  # The AX201 fails to associate on this board and NetworkManager mislabels it:
  # the log reads "association took too long" and then "asking for new secrets",
  # so a perfectly good PSK looks like a wrong password. It hit the phone
  # hotspot too, which is how we know it isn't the key.
  #
  # power_scheme=1 is CAM (radio always on). The stock 2 (balanced) parks the
  # radio mid-handshake and the AP gives up on us before the 4-way completes.
  boot.extraModprobeConfig = ''
    options iwlwifi power_save=0
    options iwlmvm power_scheme=1
  '';

  # mDNS: find network printers, be reachable as hal-9000.local on the LAN
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # AirDrop-style file drops — the module opens port 53317, which a bare
  # package install never did (LAN peers couldn't reach us)
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
}
