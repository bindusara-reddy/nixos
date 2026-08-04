{
  pkgs,
  inputs,
  config,
  host,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # if a dotfile already exists where home-manager wants to write, keep a
    # .hm-backup copy instead of refusing to activate
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {inherit inputs;};
    users.${config.var.username} = {
      imports = [
        ../home
        ../../hosts/${host}/variables.nix
      ];
      home = {
        username = "${config.var.username}";
        homeDirectory = "/home/${config.var.username}";
        stateVersion = "23.11";
      };
      programs.home-manager.enable = true;
    };
  };

  users.users.${config.var.username} = {
    isNormalUser = true;
    description = "${config.var.username}";
    # video: brightness control; dialout: serial consoles (jetson & friends);
    # gamemode: without it gamemoderun silently does nothing
    extraGroups = ["networkmanager" "wheel" "video" "dialout" "gamemode"];
    shell = pkgs.nushell;
    ignoreShellProgramCheck = true;
  };

  # a login shell must be listed in /etc/shells (chsh, some display managers check)
  environment.shells = [pkgs.nushell];
}
