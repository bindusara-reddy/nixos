{config, ...}: {
  # jj — git-compatible VCS (git repo as backend, so GitHub works as-is).
  # `jj git init --colocate` in an existing repo lets jj and git coexist.
  programs.jujutsu = {
    enable = true;
    settings = {
      user.name = config.var.git.name;
      user.email = config.var.git.email;
      ui.default-command = "log"; # bare `jj` shows the log, like `git log --oneline`
    };
  };
}
