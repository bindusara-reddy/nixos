{ host, ... }: 
let 
  inherit (import ../../hosts/${host}/variables.nix} username;
in {

  virtualisation.docker.enable = true;
  users.users."${username}".extraGroups = [ "docker" ];

}
