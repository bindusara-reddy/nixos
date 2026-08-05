{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true; # "Steam (gamescope)" session at the login screen
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
