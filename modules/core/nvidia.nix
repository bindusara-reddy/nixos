{config, ...}: let
  nvidiaDriverChannel = config.boot.kernelPackages.nvidiaPackages.beta; # stable, latest, beta, etc.
in {
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"]; # or "nvidiaLegacy470 etc.

  hardware = {
    nvidia = {
      open = true;
      nvidiaSettings = true;
      modesetting.enable = true;
      package = nvidiaDriverChannel;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        # sync.enable = true;
        # reverseSync.enable = true;

        # CHANGEME: Change those values to match your hardware (if prime is imported)
        # amdgpuBusId = "${amdID}"; # Set this to the bus ID of your AMD GPU if you have one
        intelBusId = "${config.var.intelID}"; # Set this to the bus ID of your Intel GPU if you have one
        nvidiaBusId = "${config.var.nvidiaID}"; # Set this to the bus ID of your Nvidia GPU if you have one
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
