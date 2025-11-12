{config, ...}: {
  programs.git = {
    enable = true;
    settings.user.name = config.var.git.name;
    settings.user.email = config.var.git.email;
  };
}
