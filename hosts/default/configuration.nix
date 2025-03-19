{ config, pkgs, inputs, ... }:

{
  imports = [ 

    ../../modules/core

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

  ];

  
  # LEAVE ALONE
  system.stateVersion = "23.11"; # Did you read the comment?

}
