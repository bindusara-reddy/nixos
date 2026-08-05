{
  config,
  inputs,
  pkgs,
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
      # cache.nixos.org is already a default substituter; only add extras
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  # nvd: `nvd diff /run/current-system result` — closure diffs outside nh
  # nom: `nom build` — build log with a live dependency tree
  environment.systemPackages = [pkgs.nvd pkgs.nix-output-monitor];

  programs = {
    # nicer rebuild UX: `nh os switch` (pretty diff of what changed), `nh search foo`
    nh = {
      enable = true;
      flake = config.var.flakePath;
      # replaces nix.gc — nh clean also removes stale profiles, result
      # symlinks and direnv gc roots that plain nix-collect-garbage keeps
      clean = {
        enable = config.var.autoGarbageCollect;
        extraArgs = "--keep 5 --keep-since 7d"; # same policy as the `clean` alias
      };
    };

    # run binaries that weren't built for NixOS (downloaded tools, pip wheels, mason, …)
    nix-ld.enable = true;

    # `,foo` runs any package once without installing it
    nix-index-database.comma.enable = true;
    command-not-found.enable = false; # replaced by nix-index
  };
}
