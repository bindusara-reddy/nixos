{ pkgs }:

let
  image = pkgs.fetchurl {
    url = "https://images.unsplash.com/photo-1510414842594-a61c69b5ae57";
    hash = "sha256-BagILiZrCR3DIhJEBmhK/HwbE+OHmkQcTDugxw66ZTU=";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-astronaut";
  src = pkgs.fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "5e39e0841d4942757079779b4f0087f921288af6";
    hash = "sha256-bqMnJs59vWkksJCm+NOJWgsuT4ABSyIZwnABC3JLcSc=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/Backgrounds
    rm astronaut.png
    cp -r ${image} $out/Backgrounds/astronaut.png
    cd $out/
    sed -i '9s#.*#ConfigFile=Themes/jake_the_dog.conf#' metadata.desktop
   '';
}
