{
  programs.fzf = {
    enable = true;
    defaultOptions = ["--height 40%" "--layout=reverse" "--border"];
    # gruvbox-dark (official fzf wiki scheme); no `bg` so the terminal's
    # translucent background shows through
    colors = {
      "bg+" = "#3c3836";
      fg = "#ebdbb2";
      "fg+" = "#ebdbb2";
      hl = "#928374";
      "hl+" = "#fb4934";
      header = "#928374";
      info = "#8ec07c";
      pointer = "#fb4934";
      marker = "#fb4934";
      prompt = "#fb4934";
      spinner = "#fb4934";
    };
    # atuin owns Ctrl-R history; fzf is here for fuzzy-finding files/dirs
    historyWidget.nushell.command = "";
  };
}
