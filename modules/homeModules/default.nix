{pkgs, lib, ...}: {
   
  imports = [
    ./gui/firefox.nix
    ./gui/vscode.nix
    ./terminal/tools.nix
  ];
}

