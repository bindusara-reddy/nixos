{config, ...}: {
  networking = {
    hostName = "${config.var.hostname}";
    networkmanager.enable = true;
  };

  # mDNS: find network printers, be reachable as sal-9000.local on the LAN
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
