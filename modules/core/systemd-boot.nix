{ pkgs, ... }: {

  boot = {
    loader = {
      timeout = 10;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        configurationLimit = 15;
      };
    };
    tmp.cleanOnBoot = true;
    kernelPackages =
      pkgs.linuxPackages_latest; # _zen, _hardened, _rt, _rt_latest, etc.
  };
}
