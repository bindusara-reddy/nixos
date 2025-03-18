{pkgs, ... }: {

  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = with pkgs; [ zsh ];

}
