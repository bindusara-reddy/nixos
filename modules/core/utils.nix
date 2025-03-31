{config, ...}: {
  time = {
    timeZone = config.var.timeZone;
    hardwareClockInLocalTime = true;
  };

  i18n.defaultLocale = "${config.var.defaultLocale}";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${config.var.extraLocale}";
    LC_IDENTIFICATION = "${config.var.extraLocale}";
    LC_MEASUREMENT = "${config.var.extraLocale}";
    LC_MONETARY = "${config.var.extraLocale}";
    LC_NAME = "${config.var.extraLocale}";
    LC_NUMERIC = "${config.var.extraLocale}";
    LC_PAPER = "${config.var.extraLocale}";
    LC_TELEPHONE = "${config.var.extraLocale}";
    LC_TIME = "${config.var.extraLocale}";
  };

  # XDG_Base_Directory Defaults
  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
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
