{
  config,
  lib,
  ...
}: {
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      open = true; # RTX 3060 is Ampere → open kernel modules are the supported path
      nvidiaSettings = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      powerManagement = {
        enable = true; # save/restore VRAM over suspend — fixes broken resume
        finegrained = true; # RTD3: dGPU fully powers off when nothing uses it
      };
      dynamicBoost.enable = true; # shift power budget between CPU and GPU under load

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true; # `nvidia-offload <game>` runs it on the 3060
        };

        intelBusId = "${config.var.intelID}";
        nvidiaBusId = "${config.var.nvidiaID}";
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # Extra boot entry "gaming": dGPU drives everything (sync mode) — pick it for
  # external monitors or heavy gaming sessions; costs battery on the couch.
  specialisation.gaming.configuration = {
    system.nixos.tags = ["gaming"];
    hardware.nvidia = {
      powerManagement.finegrained = lib.mkForce false;
      prime = {
        offload.enable = lib.mkForce false;
        offload.enableOffloadCmd = lib.mkForce false;
        sync.enable = lib.mkForce true;
      };
    };
  };
}
