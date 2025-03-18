{ config, lib, ... }: {

  config.var = {
    hostname = "nixos";
    username = "bindu";
    configDirectory = "/home/" + config.var.username
      + "/OS"; # The path of the nixos configuration directory

    keyboardLayout = "us";

    location = "Bengaluru";
    timeZone = "Asia/Calcutta";
    defaultLocale = "en_IN.UTF-8";
    extraLocale = "en_IN.UTF-8";

    git = {
      username = "bindusara-reddy";
      email = "bindusara1252001@gmail.com";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  # Let this here
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}
