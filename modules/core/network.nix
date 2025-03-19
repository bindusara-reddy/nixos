{ pkgs, host, ... }: 
let
  inherit (import ../../hosts/${host}/variables.nix) hostname;
in {

  networking = {
    hostName = "${hostname}";
    networkmanager.enable = true;
  };

}

