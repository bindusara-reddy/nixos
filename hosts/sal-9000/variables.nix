{
  config,
  lib,
  ...
}: {
  config.var = {
    # HAL 9000's twin sister from "2010" — the Windows half of this laptop is HAL-9000
    hostname = "sal-9000";
    username = "bindu";

    # Timezone Settings
    timeZone = "Asia/Calcutta";

    # Locale Settings
    defaultLocale = "en_IN";
    extraLocale = "en_IN";

    # Nvidia Prime bus IDs — verified against this machine's PCI topology
    # (Intel UHD iGPU = bus 0, dev 2; RTX 3060 Laptop = bus 1, dev 0)
    intelID = "PCI:0:2:0";
    nvidiaID = "PCI:1:0:0";

    # Enable Auto Garbage Collector
    autoGarbageCollect = true;

    # where the clone of this repo lives on the machine (used by nh)
    flakePath = "/home/bindu/nixos";

    git = {
      email = "bindusara1252001@gmail.com";
      name = "bindusara-reddy";
    };

    # keys that may ssh into this machine (same set as github.com/bindusara-reddy.keys)
    sshAuthorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMbBx13EqKUoPr72gt/EUabt6le66oYLF1ri2RT31xcF"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINl67Nl2BC+7VXi5CmhrAUdcLv2blskDbD/H/qLhcqHQ"
    ];
  };

  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
