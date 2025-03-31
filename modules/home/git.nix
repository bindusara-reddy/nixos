{config, ...}: {
  programs.git = {
    enable = true;
    userName = config.var.git.username;
    userEmail = config.var.git.email;
  };
}
