{ lib, pkgs, config, ... }:
let
  nvidiaDriverChannel =
    config.boot.kernelPackages.nvidiaPackages.beta; # stable, latest, beta, etc.
in {

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [
    "nvidia"
    "displayLink"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ]; # or "nvidiaLegacy470 etc.
  boot.kernelParams =
    lib.optionals (lib.elem "nvidia" config.services.xserver.videoDrivers) [
      "nvidia-drm.modeset=1"
      "nvidia_drm.fbdev=1"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
  environment.variables = {
    GBM_BACKEND = "nvidia-drm"; # If crash in firefox, remove this line
    LIBVA_DRIVER_NAME = "nvidia"; # hardware acceleration
    NVD_BACKEND = "direct";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1"; # GSync
  };
  nixpkgs.config = {
    nvidia.acceptLicense = true;
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "cudatoolkit"
        "nvidia-persistenced"
        "nvidia-settings"
        "nvidia-x11"
      ];
  };
  hardware = {
    nvidia = {
      open = false;
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
        # amdgpuBusId = "PCI:5:0:0"; # Set this to the bus ID of your AMD GPU if you have one
        intelBusId = "PCI:0:2:0"; # Set this to the bus ID of your Intel GPU if you have one
        nvidiaBusId = "PCI:1:0:0"; # Set this to the bus ID of your Nvidia GPU if you have one
      };
    };
    graphics = {
      enable = true;
      package = nvidiaDriverChannel;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        vaapiVdpau
        libvdpau-va-gl
        mesa
        egl-wayland
      ];
    };
  };
  nix.settings = {
    substituters = [ "https://cuda-maintainers.cachix.org" ];
    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };
}
