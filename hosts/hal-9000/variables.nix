{lib, ...}: {
  config.var = {
    hostname = "hal-9000";
    username = "bindu";

    # Timezone Settings
    timeZone = "Asia/Kolkata"; # canonical tzdata name ("Asia/Calcutta" is a legacy alias)

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

  # typed, so a misspelled knob is an eval error instead of a silent no-op
  options.var = lib.mkOption {
    description = "per-host knobs consumed by the modules";
    type = lib.types.submodule {
      options = let
        str = lib.mkOption {type = lib.types.str;};
        bool = lib.mkOption {type = lib.types.bool;};
      in {
        hostname = str;
        username = str;
        timeZone = str;
        defaultLocale = str;
        extraLocale = str;
        intelID = str;
        nvidiaID = str;
        autoGarbageCollect = bool;
        flakePath = str;
        git = lib.mkOption {
          type = lib.types.submodule {
            options = {
              email = str;
              name = str;
            };
          };
        };
        sshAuthorizedKeys = lib.mkOption {
          type = lib.types.listOf lib.types.singleLineStr;
        };
      };
    };
  };
}
