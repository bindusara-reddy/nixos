{ pkgs, config, ... }:
let
  hostname = config.var.hostname;
  configDir = config.var.configDirectory;
in {
  # Define your hostname.
  networking.hostName = hostname;

  # Enable networking
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  time = {
    timeZone = config.var.timeZone;
    hardwareClockInLocalTime = true;
  };

  i18n.defaultLocale = config.var.defaultLocale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = config.var.extraLocale;
    LC_IDENTIFICATION = config.var.extraLocale;
    LC_MEASUREMENT = config.var.extraLocale;
    LC_MONETARY = config.var.extraLocale;
    LC_NAME = config.var.extraLocale;
    LC_NUMERIC = config.var.extraLocale;
    LC_PAPER = config.var.extraLocale;
    LC_TELEPHONE = config.var.extraLocale;
    LC_TIME = config.var.extraLocale;
  };
 
  environment.variables = {
    XDG_DATA_HOME = "$HOME/.local/share";
    EDITOR = "nvim";
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

  programs.nano.enable = false;

  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    gcc
    wget
    curl
    xclip
  ];
}
