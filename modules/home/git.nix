{config, ...}: {
  programs = {
    git = {
      enable = true;
      settings = {
        user.name = config.var.git.name;
        user.email = config.var.git.email;

        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        fetch.prune = true;
        rerere.enabled = true;
        branch.sort = "-committerdate";
        column.ui = "auto";
        merge.conflictstyle = "zdiff3"; # conflict markers include the merge base
        diff.algorithm = "histogram";
        diff.colorMoved = "default"; # delta shows moved code as moved, not changed
      };
    };

    # syntax-highlighted diffs for git/lazygit
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "gruvbox-dark";
      };
    };

    # GitHub CLI — `gh auth login` once, then git push just works over https
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };

  # home-manager always symlinks gh/config.yml into the store, and `gh auth
  # login` wants to write that file — it fails with EROFS partway through,
  # after the token is already in the keyring. Let gh own the file. The one
  # setting worth having, git_protocol = https, is gh's own default and is
  # recorded per-host in hosts.yml regardless.
  xdg.configFile."gh/config.yml".enable = false;
}
