{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      # gamescopeSession off — it added a confusing "Steam" entry at the login
      # screen; Steam still works normally inside COSMIC (incl. gamescope via
      # launch options)
      protontricks.enable = true;
      # GE-Proton, declaratively — shows up in Steam's compat-tool dropdown,
      # no protonup-qt downloads to re-do after cleanups
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    gamemode.enable = true;

    # Game won't fullscreen, or ignores being resized? Launch options, in order
    # of what to try. First runs the game as a native Wayland client instead of
    # through XWayland, which is where most of that misbehaviour comes from
    # (needs GE-Proton, selected as the compat tool):
    #   PROTON_ENABLE_WAYLAND=1 %command%
    # Otherwise hand it a nested compositor to scale into:
    #   gamescope -f -W 1920 -H 1080 -r 144 -- %command%
    # `-w 1280 -h 720 -b` instead of `-f` for borderless. Add nvidia-offload
    # before %command% for OpenGL titles — they land on the iGPU without it.
    gamescope = {
      enable = true;
      capSysNice = true;
      enableWsi = true; # Vulkan WSI layer — fullscreen handoff for Proton
    };
  };
  environment.systemPackages = [pkgs.mangohud];
}
