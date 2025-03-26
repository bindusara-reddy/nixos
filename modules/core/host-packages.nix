{pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    btop
    curl
    gcc
    light
    pamixer
    pavucontrol
    wget
    wl-clipboard
    wlogout
  ];

}

