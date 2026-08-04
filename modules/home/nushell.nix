{
  programs.nushell = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -l --icons --git";
      la = "eza -la --icons --git";
      lt = "eza --tree --level=2 --icons";
      cat = "bat";
      vi = "nvim";
      vim = "nvim";
      ff = "fastfetch";
      lg = "lazygit";

      # the daily drivers — nh knows the flake path from var.flakePath
      rebuild = "nh os switch";
      update = "nh os switch --update";
      clean = "nh clean all --keep 5 --keep-since 7d";
    };
    settings = {
      show_banner = false;
      edit_mode = "vi"; # you said you're good enough to use vim — prove it in the shell
      buffer_editor = "nvim";
      completions = {
        case_sensitive = false;
        quick = true;
        partial = true;
        algorithm = "prefix";
      };
    };
  };
}
