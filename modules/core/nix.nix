{
  config,
  inputs,
  ...
}: {
  imports = [inputs.nix-index-database.nixosModules.nix-index];

  nixpkgs.config = {
    allowUnfree = true;
  };
  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    channel.enable = false;
    # `nix run nixpkgs#foo` / `nix shell nixpkgs#foo` reuse this flake's pin (no re-download)
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      keep-outputs = true; # don't garbage-collect direnv dev shells
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    gc = {
      automatic = config.var.autoGarbageCollect;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # nicer rebuild UX: `nh os switch` (pretty diff of what changed), `nh search foo`
  programs.nh = {
    enable = true;
    flake = config.var.flakePath;
  };

  # run binaries that weren't built for NixOS (downloaded tools, pip wheels, mason, …)
  programs.nix-ld.enable = true;

  # `,foo` runs any package once without installing it
  programs.nix-index-database.comma.enable = true;
  programs.command-not-found.enable = false; # replaced by nix-index
}
