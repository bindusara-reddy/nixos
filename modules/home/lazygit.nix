{
  # nvf's toggleterm has a lazygit binding — now the binary actually exists
  programs.lazygit = {
    enable = true;
    settings = {
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };
      # gruvbox-dark (im-AMS/gruvbox-material-lazygit, dark_medium_original)
      gui = {
        nerdFontsVersion = "3";
        theme = {
          activeBorderColor = ["#ebdbb2" "bold"];
          inactiveBorderColor = ["#928374"];
          optionsTextColor = ["#fabd2f"];
          selectedLineBgColor = ["#5a524c"];
          cherryPickedCommitBgColor = ["#5a524c"];
          cherryPickedCommitFgColor = ["#fe8019" "bold" "reverse"];
          unstagedChangesColor = ["#cc241d"];
          defaultFgColor = ["#ebdbb2"];
          searchingActiveBorderColor = ["#cc241d"];
        };
      };
    };
  };
}
