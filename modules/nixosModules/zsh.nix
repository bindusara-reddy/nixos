{pkgs, ... }: {

  users.defaultUserShell = [ pkgs.zsh ];
  environment.pathsToLink = [ "/share/zsh" ];

}
