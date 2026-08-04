{config, ...}: {
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    # don't run dockerd from boot on a battery-powered laptop —
    # the socket starts it on first `docker` command instead
    enableOnBoot = false;
  };

  # GPU containers via CDI: `docker run --device nvidia.com/gpu=all …`
  hardware.nvidia-container-toolkit.enable = true;

  users.users."${config.var.username}".extraGroups = ["docker"];
}
