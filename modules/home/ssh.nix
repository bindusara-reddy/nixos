{
  programs.ssh = {
    enable = true;
    # explicit instead of home-manager's transitional implicit defaults;
    # the "*" block below carries what we actually want everywhere
    enableDefaultConfig = false;
    settings = {
      # deepblue and the jetson rejoined 2026-08 as nodes shared into the
      # tailnet; MagicDNS names rather than the 100.x IPs, which changed
      # across the leave/rejoin. Both use the main id_ed25519 — the old
      # dedicated per-host keys are gone.
      "deepblue deep-blue" = {
        hostname = "deep-blue.taild98811.ts.net";
        user = "waterfly";
        identityFile = "~/.ssh/id_ed25519";
      };
      "jetson deep-thought" = {
        hostname = "jetson.taild98811.ts.net";
        user = "bindu";
        identityFile = "~/.ssh/id_ed25519";
      };
      # `ssh -N jetson-dash` tunnels the jetson's Hermes dashboard/gateway to
      # http://localhost:9119 — separate alias so plain `ssh jetson` stays quiet
      "jetson-dash" = {
        hostname = "jetson.taild98811.ts.net";
        user = "bindu";
        identityFile = "~/.ssh/id_ed25519";
        LocalForward = "9119 127.0.0.1:9119";
      };
      "*" = {
        addKeysToAgent = "yes";
        serverAliveInterval = 60;
      };
    };
  };
}
