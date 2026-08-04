{pkgs, ...}: {
  # terminal file manager — `y` to launch, q to quit back into the same dir
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    shellWrapperName = "y";

    # full gruvbox UI + preview syntax theme (linked from yazi-rs/flavors)
    flavors.gruvbox-dark = pkgs.fetchFromGitHub {
      owner = "bennyyip";
      repo = "gruvbox-dark.yazi";
      rev = "619fdc5844db0c04f6115a62cf218e707de2821e";
      hash = "sha256-Y/i+eS04T2+Sg/Z7/CGbuQHo5jxewXIgORTQm25uQb4=";
    };
    theme.flavor.dark = "gruvbox-dark";

    plugins = {
      inherit (pkgs.yaziPlugins) full-border git smart-enter;
    };
    initLua = ''
      require("full-border"):setup { type = ui.Border.ROUNDED }
      require("git"):setup()
    '';
    keymap.mgr.prepend_keymap = [
      {
        on = "l";
        run = "plugin smart-enter";
        desc = "Enter the child directory, or open the file";
      }
    ];
    settings.plugin.prepend_fetchers = [
      {
        url = "*";
        run = "git";
        group = "git";
      }
      {
        url = "*/";
        run = "git";
        group = "git";
      }
    ];
  };
}
