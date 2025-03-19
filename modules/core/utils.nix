{ pkgs, host, ... }:
let 
  inherit (import ../../hosts/${host}/variables.nix) timeZone defaultLocale extraLocale;
in {  
  
  time = {
    timeZone = timeZone;
    hardwareClockInLocalTime = true;
  };

  i18n.defaultLocale = "${defaultLocale}";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${extraLocale}";
    LC_IDENTIFICATION = "${extraLocale}";
    LC_MEASUREMENT = "${extraLocale}";
    LC_MONETARY = "${extraLocale}";
    LC_NAME = "${extraLocale}";
    LC_NUMERIC = "${extraLocale}";
    LC_PAPER = "${extraLocale}";
    LC_TELEPHONE = "${extraLocale}";
    LC_TIME = "${extraLocale}";
  };
 
  environment.variables = {
    XDG_DATA_HOME = "$HOME/.local/share";
  };

# Faster rebuilding
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

}
