{pkgs, ...}: {
  programs.btop = {
    enable = true;
    # NVML runpath so the GPU panel can see the RTX 3060
    # (note: polling NVML keeps the dGPU awake while btop is open)
    package = pkgs.btop.override {cudaSupport = true;};
    settings = {
      color_theme = "gruvbox_dark_v2";
      theme_background = false;
      vim_keys = true;
    };
  };
}
