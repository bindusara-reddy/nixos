{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    file
    gcc
    git
    lm_sensors
    pciutils
    psmisc
    usbutils
    wget
    wl-clipboard
  ];
}
