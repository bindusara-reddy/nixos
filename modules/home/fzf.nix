{
  programs.fzf = {
    enable = true;
    defaultOptions = ["--height 40%" "--border"];
    # atuin owns Ctrl-R history; fzf is here for fuzzy-finding files/dirs
    historyWidget.nushell.command = "";
  };
}
