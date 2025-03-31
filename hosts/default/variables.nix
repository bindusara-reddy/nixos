{
  config,
  lib,
  ...
}: {
  config.var = {
    hostname = "nixos";
    username = "bindu";

    # Timezone Settings
    timeZone = "Asia/Calcutta";

    # Locale Settings
    defaultLocale = "en_IN";
    extraLocale = "en_IN";

    # For Nvidia Prime support
    intelID = "PCI:1:0:0";
    nvidiaID = "PCI:0:2:0";

    # Enable Auto Garbage Collector
    autoGarbageCollect = true;

    git = {
      email = "bindusara1252001@gmail.com";
      username = "bindusara-reddy";
    };
  };

  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
