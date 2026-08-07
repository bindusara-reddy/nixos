{
  programs.ssh = {
    enable = true;
    # explicit instead of home-manager's transitional implicit defaults;
    # the "*" block below carries what we actually want everywhere
    enableDefaultConfig = false;
    settings = {
      # deepblue and the jetson rejoined 2026-08 as nodes shared into the
      # tailnet; MagicDNS names rather than the 100.x IPs, which changed
      # across the leave/rejoin. The old per-host keys died with the old
      # nodes, so these are freshly generated — one key per host, never the
      # id_ed25519 that authenticates to GitHub. deepblue in particular is
      # someone else's machine with other people's keys in authorized_keys.
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
