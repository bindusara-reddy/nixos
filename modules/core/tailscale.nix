{
  # join the tailnet with the other machines (jetson, deepblue, HAL-9000):
  # run `sudo tailscale up` once after the first rebuild.
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    # open UDP 41641 so peers connect directly instead of via DERP relays
    openFirewall = true;
  };

  # trust tailnet traffic — this is what lets ssh in while the firewall stays shut
  networking.firewall.trustedInterfaces = ["tailscale0"];
}
