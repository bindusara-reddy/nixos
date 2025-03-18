{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ../../modules/nixosModules

      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Config Variables
      ./variables.nix
    ];

  home-manager.users."${config.var.username}"= import ./home.nix;
  





  # LEAVE ALONE
  system.stateVersion = "23.11"; # Did you read the comment?

}
