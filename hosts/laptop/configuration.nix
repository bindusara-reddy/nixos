{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Mostly system related configuration
      ../../modules/nixosModules/nvidia.nix # CHANGEME: Remove this line if you don't have an Nvidia GPU
      ../../modules/nixosModules/audio.nix
      ../../modules/nixosModules/gnome.nix
      ../../modules/nixosModules/home-manager.nix
      ../../modules/nixosModules/nix.nix
      ../../modules/nixosModules/systemd-boot.nix
      ../../modules/nixosModules/users.nix
      ../../modules/nixosModules/utils.nix
      ../../modules/nixosModules/docker.nix

      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Config Variables
      ./variables.nix
    ];

  home-manager.users."${config.var.username}"= import ./home.nix;
  





  # LEAVE ALONE
  system.stateVersion = "23.11"; # Did you read the comment?

}
