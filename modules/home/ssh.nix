{
  # the rest of the fleet, one word away. Copy the matching private keys from
  # the Windows side (or generate new ones) into ~/.ssh first.
  programs.ssh = {
    enable = true;
    # explicit instead of home-manager's transitional implicit defaults;
    # the "*" block below carries what we actually want everywhere
    enableDefaultConfig = false;
    settings = {
      "jetson deep-thought" = {
        hostname = "100.110.162.72";
        user = "bindu";
        identityFile = "~/.ssh/id_ed25519_jetson";
        # any `ssh jetson` also exposes the jetson's Hermes dashboard/gateway
        # at http://localhost:9119 on this machine
        LocalForward = "9119 127.0.0.1:9119";
      };
      "deepblue deep-blue" = {
        hostname = "100.111.247.29";
        user = "waterfly";
        # historically named id_ed25519_amdbox; renamed when amdbox left the tailnet
        identityFile = "~/.ssh/id_ed25519_deepblue";
      };
      "*" = {
        addKeysToAgent = "yes";
        serverAliveInterval = 60;
      };
    };
  };
}
