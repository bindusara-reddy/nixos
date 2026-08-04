{pkgs, ...}: {
  boot = {
    loader = {
      timeout = 10;
      # let the bootloader installer write EFI variables (boot order etc.)
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        configurationLimit = 5;
      };
    };
    tmp.cleanOnBoot = true;
    kernelPackages =
      pkgs.linuxPackages_latest; # _zen, _hardened, _rt, _rt_latest, etc.

    # graphical boot splash instead of scrolling text (press Esc to peek at the log)
    plymouth.enable = true;
    kernelParams = ["quiet"];
  };
}
