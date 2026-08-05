{config, ...}: {
  time = {
    timeZone = config.var.timeZone;
    # RTC stays in UTC (the default): the kernel reads the RTC as UTC at
    # early boot, so a local-time RTC made every boot start +5:30 ahead
    # (wrong greeter/lock clock, wrong when offline). NixOS is the primary
    # OS — Windows adapts via its RealTimeIsUniversal registry switch.
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

    # Electron/Chromium apps (vscode, discord, …) render natively on Wayland
    NIXOS_OZONE_WL = "1";
  };

  # escape hatch for apps not in nixpkgs: flatpak install flathub <app>
  # (first run once: flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo)
  services.flatpak.enable = true;

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
