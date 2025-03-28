{ pkgs, inputs, username, host, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {

    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs username host;};
    users.${username} = {
      imports = [ ../home ];
      home = {
        username = "${username}";
	homeDirectory = "/home/${username}";
	stateVersion = "23.11";
      };
      programs.home-manager.enable = true;
    };
  }; 

  users.users.${username} = {
      isNormalUser = true;
      description = "${username}";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.nushell;
      ignoreShellProgramCheck = true;
  };
}
