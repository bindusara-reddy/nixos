{
  config,
  lib,
  pkgs,
  ...
}: {
  # COSMIC settings, captured from ~/.config/cosmic into ./cosmic-settings and
  # re-applied (as writable copies, not symlinks) on every activation — a
  # rebuild re-asserts exactly what was captured. The Settings app still works
  # live between rebuilds; after changing anything there, run `cosmic-save` to
  # bake the new state into the repo, otherwise the next rebuild reverts it.
  home.activation.cosmicSettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run cp -rT --no-preserve=mode,ownership ${./cosmic-settings} \
      "${config.home.homeDirectory}/.config/cosmic"
  '';

  home.packages = [
    (pkgs.writeShellScriptBin "cosmic-save" ''
      set -euo pipefail
      dest="${config.home.homeDirectory}/nixos/modules/home/cosmic-settings"
      rm -rf "$dest"
      cp -rT "$HOME/.config/cosmic" "$dest"
      echo "captured ~/.config/cosmic -> $dest"
      echo "next: cd ~/nixos, jj describe -m 'cosmic: re-capture settings', rebuild"
    '')
  ];
}
