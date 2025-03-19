{pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    neovim
    gcc
    wget
    curl
    xclip
  ];

}

