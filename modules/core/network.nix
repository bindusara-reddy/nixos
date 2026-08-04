{config, ...}: {
  networking = {
    hostName = "${config.var.hostname}";
    networkmanager.enable = true;
  };

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
