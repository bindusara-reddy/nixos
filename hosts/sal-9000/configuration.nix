{...}: {
  imports = [
    ../../modules/core

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./variables.nix
  ];

  # mount the ESP root-only — kernels, initrds and systemd-boot's random-seed
  # are nobody else's business (merges with the generated fileSystems entry,
  # which bootstrap.sh would overwrite if this lived in hardware-configuration.nix)
  fileSystems."/boot".options = ["fmask=0077" "dmask=0077"];

  # LEAVE ALONE
  system.stateVersion = "23.11"; # Did you read the comment?
}
