{ pkgs, ... }: {
  services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "${ 
      let
        imgLink = "https://images.unsplash.com/photo-1590867286251-8e26d9f255c0";
        image = pkgs.fetchurl {
          url = imgLink;
          hash = "sha256-ITRgLGlsyN3VxOhjsZDtOypFDM8t7rExNxHkNG1KUHo=";
        };
      in
        pkgs.stdenv.mkDerivation {
          name = "sddm-theme";
          src = pkgs.fetchFromGitHub {
            owner = "MarianArlt";
            repo = "sddm-sugar-dark";
            rev = "v1.2";
            hash = "sha256-C3qB9hFUeuT5+Dos2zFj5SyQegnghpoFV9wHvE9VoD8=";
          };
          installPhase = ''
            mkdir -p $out
            cp -R ./* $out/
            cd $out/
            rm Background.jpg
            cp -r ${image} $out/Background.jpg
          '';
        }
      }"; 
  };
}
