{pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    btop
    curl
    gcc
    pavucontrol
    wget
    wl-clipboard
  ];

}

