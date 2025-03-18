{
  programs.git.enable = true;
  programs.zoxide.enable = true;
  programs.eza.enable = true;
  programs.kitty.enable = true;

  programs.zsh = {

    enable = true;
    autosuggestion = {
      enable = true;
      strategy = [ "completion" "match_prev_cmd" "history" ];
    };

    shellAliases = {
      ls = "eza";
    };
 
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" "cursor" "root" ];
    };
  };

  programs.oh-my-posh = {

    enable = true;
    useTheme = "atomic";

  };

  programs.neovim.defaultEditor = true;
}
