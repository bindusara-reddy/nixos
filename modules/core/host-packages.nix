{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    gcc
    wget
    wl-clipboard
    nomachine-client
  ];
}
