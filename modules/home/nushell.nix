{
  programs.nushell = {
    enable = true;
    shellAliases = {
      # no `ls = eza` — that would shadow nushell's structured ls and break
      # pipelines like `ls | where size > 1mb`; ll/la/lt cover pretty listings
      # (icons/git flags come from the eza module's own alias, see eza.nix)
      ll = "eza -l";
      la = "eza -la";
      lt = "eza --tree --level=2";
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
      # emacs = the standard readline keys everyone's fingers already know:
      # arrows just work, Ctrl-A/E home/end, Ctrl-W delete word, Alt-B/F by word.
      # (vim stays for editing — Ctrl-O drops the current line into nvim)
      edit_mode = "emacs";
      buffer_editor = "nvim";
      completions = {
        case_sensitive = false;
        quick = true;
        partial = true;
        algorithm = "fuzzy"; # "nxrb" finds nixos-rebuild — forgiving > pedantic
      };
    };
  };
}
