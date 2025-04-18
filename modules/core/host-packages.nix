{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    gcc
    wget
    wl-clipboard
    rustdesk
  ];
}
