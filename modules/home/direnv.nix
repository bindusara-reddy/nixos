{
  # cd into a project with a .envrc / flake.nix devshell and the tools are just there
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableNushellIntegration = true;
    silent = true;
  };
}
