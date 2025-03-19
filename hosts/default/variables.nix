{

  hostname = "nixos";
  username = "bindu";

  # Timezone Settings
  timeZone = "Asia/Calcutta";

  # Locale Settings
  defaultLocale = "en_IN";
  extraLocale = "en_IN";

  # Program Options
  browser = "firefox"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "kitty"; # Set Default System Terminal
  keyboardLayout = "us";
  consolekeyMap = "us";

  # For Nvidia Prime support
  intelID = "PCI:1:0:0";
  nvidiaID = "PCI:0:2:0";

  # Enable Auto Garbage Collector
  autoGarbageCollect = true;

}
