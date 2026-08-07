{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      format = lib.concatStrings [
        "[](color_orange)"
        "$os"
        "$username"
        "[](bg:color_yellow fg:color_orange)"
        "$directory"
        "[](fg:color_yellow bg:color_aqua)"
        # jj first: in a jj repo the custom.git_* modules stay silent, and
        # outside one they render the built-ins via `starship module`. The
        # built-ins are configured below but kept out of this format string,
        # otherwise they would draw twice.
        "\${custom.jj}"
        "\${custom.git_branch}"
        "\${custom.git_status}"
        "[](fg:color_aqua bg:color_blue)"
        "$c"
        "$rust"
        "$python"
        "$nix_shell"
        "[](fg:color_blue bg:color_bg3)"
        "$docker_context"
        "[](fg:color_bg3 bg:color_bg1)"
        "$time"
        "$cmd_duration"
        "[ ](fg:color_bg1)"
        "$line_break$character"
      ];
      palette = "gruvbox_dark";
      palettes.gruvbox_dark = {
        color_fg0 = "#fbf1c7";
        color_bg1 = "#3c3836";
        color_bg3 = "#665c54";
        color_blue = "#458588";
        color_aqua = "#689d6a";
        color_green = "#98971a";
        color_orange = "#d65d0e";
        color_purple = "#b16286";
        color_red = "#cc241d";
        color_yellow = "#d79921";
      };
      os = {
        disabled = false;
        style = "bg:color_orange fg:color_fg0";
        symbols = {
          Windows = "󰍲";
          Ubuntu = "󰕈";
          Macos = "󰀵";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Arch = "󰣇";
          Pop = "";
          NixOS = "";
        };
      };
      username = {
        show_always = true;
        style_user = "bg:color_orange fg:color_fg0";
        style_root = "bg:color_orange fg:color_fg0";
        format = "[ $user ]($style)";
      };
      directory = {
        style = "fg:color_fg0 bg:color_yellow";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Projects" = "󰲋 ";
          "OS" = "";
        };
      };
      git_branch = {
        symbol = "󰊢";
        style = "bg:color_aqua";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
      };
      git_status = {
        style = "bg:color_aqua";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
        # counts, not just symbols: "!2 +1 ⇡3" tells the whole story
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?\${count}";
        staged = "+\${count}";
        modified = "!\${count}";
        renamed = "»\${count}";
        deleted = "✘\${count}";
      };
      # jj keeps git's HEAD detached and its index a commit behind, so the
      # built-in git modules read a jj repo as "HEAD" with everything jj has
      # already committed showing up as untracked. These three replace them.
      # shell: starship would otherwise run these through STARSHIP_SHELL, i.e.
      # nushell, which cannot parse `>/dev/null 2>&1 ||`. It pipes the command
      # in on stdin, so this is ["sh"] and not ["sh" "-c"].
      custom.jj = {
        description = "bookmark (or change id) of the working-copy commit";
        when = "jj root";
        shell = ["sh"];
        # --ignore-working-copy: never let drawing a prompt snapshot the repo
        command = "jj log -r @ --no-graph --ignore-working-copy --limit 1 -T 'separate(\" \", coalesce(bookmarks.join(\",\"), change_id.shortest(6)), if(conflict, \"×\"), if(empty, \"\", \"!\"))'";
        symbol = "󱗆";
        style = "bg:color_aqua";
        format = "[[ $symbol $output ](fg:color_fg0 bg:color_aqua)]($style)";
        ignore_timeout = true;
      };
      custom.git_branch = {
        description = "built-in git_branch, but only outside a jj repo";
        when = true;
        shell = ["sh"];
        command = "jj root >/dev/null 2>&1 || starship module git_branch";
        format = "$output";
      };
      custom.git_status = {
        description = "built-in git_status, but only outside a jj repo";
        when = true;
        shell = ["sh"];
        command = "jj root >/dev/null 2>&1 || starship module git_status";
        format = "$output";
      };
      # how long the last command took (only shown past 2s)
      cmd_duration = {
        min_time = 2000;
        format = "[[ 󱦟 $duration ](fg:color_fg0 bg:color_bg1)]($style)";
        style = "bg:color_bg1";
      };
      c = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
      python = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
      # shows when you're inside `nix develop` / a direnv dev shell
      nix_shell = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol $state ](fg:color_fg0 bg:color_blue)]($style)";
      };
      docker_context = {
        symbol = "";
        style = "bg:color_bg3";
        format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[ 󱑂  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };
      line_break.disabled = false;
      character = {
        disabled = false;
        success_symbol = "[󰫈](bold fg:color_green)";
        error_symbol = "[](bold fg:color_red)";
        vimcmd_symbol = "[](bold fg:color_green)";
      };
    };
  };
}
