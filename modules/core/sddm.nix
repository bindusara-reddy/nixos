{ pkgs, ... }: {
  services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "${import ./sddm-astronaut.nix {inherit pkgs;}}";
      extraPackages = with pkgs; [
        kdePackages.qtmultimedia 
      ];
  };
}
