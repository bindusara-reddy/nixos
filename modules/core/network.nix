{config, ...}: {
  networking = {
    hostName = "${config.var.hostname}";
    networkmanager.enable = true;
  };
}
