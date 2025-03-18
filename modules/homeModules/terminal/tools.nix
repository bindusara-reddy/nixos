{
  programs.git.enable = true;
  programs.kitty.enable = true;
  programs.zoxide.enable = true;
  programs.eza.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
  };
  programs.oh-my-posh.enable = true;
  programs.oh-my-posh.useTheme = "atomic";
}
