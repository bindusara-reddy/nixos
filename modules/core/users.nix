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
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.nushell;
    ignoreShellProgramCheck = true;
  };
}
