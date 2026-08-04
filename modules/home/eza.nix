{
  # flags live here once — the module emits an `eza = "eza --icons auto --git"`
  # alias that ll/la/lt in nushell.nix inherit
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };
}
