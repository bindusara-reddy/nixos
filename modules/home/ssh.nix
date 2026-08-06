{
  # deepblue and the jetson left the tailnet, and their keys are gone with it,
  # so the per-host blocks that pointed at 100.x addresses and
  # ~/.ssh/id_ed25519_{deepblue,jetson} are dead weight — removed. Add them
  # back here if either machine rejoins.
  programs.ssh = {
    enable = true;
    # explicit instead of home-manager's transitional implicit defaults;
    # the "*" block below carries what we actually want everywhere
    enableDefaultConfig = false;
    settings = {
      "*" = {
        addKeysToAgent = "yes";
        serverAliveInterval = 60;
      };
    };
  };
}
