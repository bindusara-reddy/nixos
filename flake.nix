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

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      default = 
        nixpkgs.lib.nixosSystem {

	  inherit system;

          specialArgs = {
	    inherit inputs;
	    host = "laptop";
	  };

          modules = [ ./hosts/laptop/configuration.nix ];
        };
    };
  };
}
