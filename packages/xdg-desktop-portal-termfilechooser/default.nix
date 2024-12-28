{pkgs, ...}:
pkgs.clangStdenv.mkDerivation {
  pname = "xdg-desktop-portal-termfilechooser";
  version = "0.4.0";

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
  ];

  buildInputs = with pkgs; [
    inih
    basu
  ];

  mesonAutoFeatures = "auto";

  src = pkgs.fetchFromGitHub {
    owner = "boydaihungst";
    repo = "xdg-desktop-portal-termfilechooser";
    rev = "a0b20c06e3d45cf57218c03fce1111671a617312";
    hash = "sha256-MOS2dS2PeH5O0FKxZfcJUAmCViOngXHZCyjRmwAqzqE=";
  };
}
