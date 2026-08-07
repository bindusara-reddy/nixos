{osConfig, ...}: {
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

      # `hermes` is the laptop's own; `hermes-jetson` runs the jetson's hermes
      # (its gateway, keys, skunkworks — the laptop is just the screen)
      hermes-jetson = "ssh -t jetson /home/bindu/.local/bin/hermes";

      # the daily drivers — nh knows the flake path from var.flakePath
      # (`rebuild`, `update` and `clean` are defs in extraConfig below — they
      # need logic an alias can't hold)
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
      # sqlite history: bigger, with timestamps + cwd per command, and
      # isolation keeps parallel wezterm panes from mixing up-arrow history
      # (other panes' commands still reachable via Ctrl-R)
      history = {
        file_format = "sqlite";
        max_size = 1000000;
        sync_on_enter = true;
        isolation = true;
      };
      # IDE-style completion dropdown: bordered, with the flag/command
      # description in a side panel (replaces the flat columnar menu)
      menus = [
        {
          name = "completion_menu";
          only_buffer_difference = false;
          marker = "| ";
          type = {
            layout = "ide";
            max_completion_width = 50;
            max_completion_height = 10;
            border = true;
            description_mode = "prefer_right";
            min_description_width = 15;
            max_description_width = 50;
            max_description_height = 10;
            description_offset = 1;
          };
          style = {
            text = "green";
            selected_text = {attr = "r";};
            description_text = "yellow";
            match_text = {attr = "u";};
            selected_match_text = {attr = "ur";};
          };
        }
      ];
    };
    # gruvbox file colors for nushell's ls (eza/fd honor LS_COLORS too)
    extraEnv = ''
      $env.LS_COLORS = (vivid generate gruvbox-dark | str trim)
    '';
    # typo a command → get told which nix package provides it (nix-index db)
    # (char newline) instead of backslash escapes: '' strings pass backslashes
    # through verbatim and nu chokes on them — this broke the whole config once
    extraConfig = ''
      $env.config.hooks.command_not_found = {|cmd|
        try {
          let pkgs = (nix-locate --minimal --no-group --type x --type s --whole-name $"/bin/($cmd)")
          if ($pkgs | is-empty) { return null }
          let top = ($pkgs | lines | first 10 | str join (char newline))
          $"($cmd) may be provided by:(char newline)($top)(char newline)run once without installing: ,($cmd)"
        }
      }

      # Flakes only include git-*tracked* files, and jj keeps new files out of
      # git's index until a commit lands them in HEAD — so a plain rebuild dies
      # with "path does not exist" while `jj st` swears the file is right there.
      # Edits to already-tracked files need no commit: nix reads dirty contents.
      def jj-track-new [caller: string] {
        let flake = "${osConfig.var.flakePath}"
        let new = (git -C $flake ls-files --others --exclude-standard | lines)
        if ($new | is-not-empty) {
          print $"($caller): jj-committing new files the flake can't see yet: ($new | str join ', ')"
          jj -R $flake commit -m $"($caller): auto-commit to track new files"
        }
      }

      # rebuild = apply the config as-is; update = bump all flake inputs first
      def rebuild [] {
        jj-track-new rebuild
        nh os switch
      }

      def update [] {
        jj-track-new update
        nh os switch --update
      }

      # keep only the newest generation — at --keep 1 this forfeits rollback
      # until the next successful rebuild; the weekly auto-clean (nix.nix)
      # still keeps 5/7d.
      # The second line is not redundant: nh deletes profile generations but
      # never re-runs the bootloader installer, so /boot/loader/entries keeps a
      # .conf per deleted generation — menu entries pointing at store paths the
      # GC already took, which fail if you pick them. switch-to-configuration
      # rewrites the entries from the surviving profile links.
      def clean [--keep (-k): int = 1] {
        nh clean all --keep $keep --keep-since 0h
        sudo /nix/var/nix/profiles/system/bin/switch-to-configuration boot
      }
    '';
  };
}
