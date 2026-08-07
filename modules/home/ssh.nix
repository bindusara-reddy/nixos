{
  programs.ssh = {
    enable = true;
    # explicit instead of home-manager's transitional implicit defaults;
    # the "*" block below carries what we actually want everywhere
    enableDefaultConfig = false;
    settings = {
      # MagicDNS names, not 100.x IPs — those change if a node rejoins.
      # One key per host, so any single host can be revoked on its own.
      "deepblue deep-blue" = {
        hostname = "deep-blue.taild98811.ts.net";
        user = "waterfly";
        identityFile = "~/.ssh/id_ed25519_deepblue";
      };
      "jetson deep-thought" = {
        hostname = "jetson.taild98811.ts.net";
        user = "bindu";
        identityFile = "~/.ssh/id_ed25519_jetson";
      };
      # `ssh -N jetson-dash` tunnels the jetson's Hermes dashboard/gateway to
      # http://localhost:9119 — separate alias so plain `ssh jetson` stays quiet
      "jetson-dash" = {
        hostname = "jetson.taild98811.ts.net";
        user = "bindu";
        identityFile = "~/.ssh/id_ed25519_jetson";
        LocalForward = "9119 127.0.0.1:9119";
      };
      "*" = {
        addKeysToAgent = "yes";
        serverAliveInterval = 60;
      };
    };
  };
}
