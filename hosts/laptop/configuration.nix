{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Mostly system related configuration
      ../../nixos/nvidia.nix # CHANGEME: Remove this line if you don't have an Nvidia GPU
      ../../nixos/audio.nix
      ../../nixos/git.nix
      ../../nixos/gnome.nix
      ../../nixos/home-manager.nix
      ../../nixos/nix.nix
      ../../nixos/systemd-boot.nix
      ../../nixos/users.nix
      ../../nixos/utils.nix
      ../../nixos/docker.nix

      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Config Variables
      ./variables.nix
    ];

  home-manager.users."$(config.var.username)"= import ./home.nix;
  





  # LEAVE ALONE
  system.stateVersion = "23.11"; # Did you read the comment?

}
