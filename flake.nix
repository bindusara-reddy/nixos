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
    host = "laptop";

  in {

    nixosConfigurations = {

      "${host}" = 

        nixpkgs.lib.nixosSystem rec {

          specialArgs = {
	    inherit system;
	    inherit inputs;
	    inherit host;
	  };

          modules = [ ./hosts/${host}/configuration.nix ];

        };
    };
  };
}
