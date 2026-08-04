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
      };
      "deepblue deep-blue" = {
        hostname = "100.111.247.29";
        user = "waterfly";
        identityFile = "~/.ssh/id_ed25519_amdbox";
      };
      "*" = {
        addKeysToAgent = "yes";
        serverAliveInterval = 60;
      };
    };
  };
}
