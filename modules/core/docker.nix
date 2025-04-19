{config, ...}: {
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  users.users."${config.var.username}".extraGroups = ["docker"];
}
