{
  # nvf's toggleterm has a lazygit binding — now the binary actually exists
  programs.lazygit = {
    enable = true;
    settings = {
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };
    };
  };
}
