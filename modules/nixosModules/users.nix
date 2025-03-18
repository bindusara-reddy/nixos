{ config, pkgs, ... }:
let username = config.var.username;
in {
  # programs.zsh.enable = true; # enable z shell for this user
  users = {
    # defaultUserShell = pkgs.zsh; # default shell for this user
    users.${username} = {
      isNormalUser = true;
      description = "${username} account";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
