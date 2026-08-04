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
      settings.git_protocol = "https";
    };
  };
}
