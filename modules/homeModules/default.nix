{pkgs, lib, ...}: {
   
  imports = [
    ./gui/firefox.nix
    ./gui/zed.nix
    ./terminal/tools.nix
  ];
}

