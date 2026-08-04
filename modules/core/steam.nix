{pkgs, ...}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true; # "Steam (gamescope)" session at the login screen
    protontricks.enable = true;
  };

  # in Steam launch options: `gamemoderun %command%` or `mangohud %command%`
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  environment.systemPackages = [pkgs.mangohud];
}
