{ config, pkgs, ... }: {

 imports = [
    # user-specific configuration
    ./variables.nix

    # Home manager modules directory
    ../../modules/homeModules
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      vlc # Video player     
      # Dev
      python313 
    ];
    
    file = {};

    sessionVariables = {};


    # Don't touch this
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
} 
