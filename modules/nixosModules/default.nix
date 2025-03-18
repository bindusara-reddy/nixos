{
  imports = [
    # System related configuration
    ./nvidia.nix # CHANGEME: Remove this line if you don't have an Nvidia GPU
    ./audio.nix
    ./home-manager.nix
    ./nix.nix
    ./systemd-boot.nix
    ./users.nix
    ./utils.nix
    ./gnome.nix

    # Application specific
    ./steam.nix
    ./docker.nix
    ./zsh.nix


  ];

}
