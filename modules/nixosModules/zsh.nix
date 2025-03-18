{pkgs, ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
  };

  users.defaultUserShell =  [ pkgs.zsh ];
}
