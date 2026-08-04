{config, ...}: {
  # ssh INTO this laptop — key-only, and the firewall only admits it over
  # tailscale (see tailscale.nix), so nothing is exposed on hostile wifi.
  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.${config.var.username}.openssh.authorizedKeys.keys =
    config.var.sshAuthorizedKeys;
}
