{
  description = "Himalaya — NixOS for the MSI Katana GF66 (sal-9000)";

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

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `,foo` — run any program once without installing it
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hermes — Nous Research's self-improving agent CLI
    hermes-agent = {
      url = "github:nousresearch/hermes-agent";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    mkHost = host:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit host;
        };
        modules = [./hosts/${host}/configuration.nix];
      };
  in {
    nixosConfigurations."sal-9000" = mkHost "sal-9000";

    # nix fmt
    formatter.${system} = pkgs.alejandra;

    # nix develop — tools for hacking on this config
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [nil alejandra statix deadnix];
    };
  };
}
