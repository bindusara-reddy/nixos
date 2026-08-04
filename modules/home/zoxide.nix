{
  # frecency-ranked cd: plain `cd projects` works from anywhere once visited,
  # `cdi` opens the interactive fzf picker. Zero new muscle memory.
  programs.zoxide = {
    enable = true;
    options = ["--cmd" "cd"];
  };
}
