{ host, inputs, ... }:
let 
  inherit (import ../../hosts/${host}/variables.nix) autoGarbageCollect;
in {
  nixpkgs.config = {
    allowUnfree = true;
  };
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    channel.enable = false;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    gc = {
      automatic = autoGarbageCollect;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
