{
  description = "Nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      default = 
        nixpkgs.lib.nixosSystem {

	  system = "x86_64-linux";
	  host = "laptop";

          specialArgs = {
	    inherit inputs;
	    inherit host;
	  };

          modules = [
            ./hosts/laptop/configuration.nix
          ];
        };
    };
  };
}
