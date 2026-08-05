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

    # in Steam launch options: `gamemoderun %command%` or `mangohud %command%`
    gamemode.enable = true;
    gamescope.enable = true;
  };
  environment.systemPackages = [pkgs.mangohud];
}
