{pkgs, ...}:
pkgs.stdenvNoCC.mkDerivation rec {
  pname = "devicon";
  version = "2.16.0";

  src = pkgs.fetchFromGitHub {
    repo = "devicon";
    owner = "devicons";
    rev = "v${version}";
    hash = "sha256-VLr84XWkus6d3Hj1mV9TDQjtewAhadNVjiwd9p/aXfY=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 fonts/*.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';
}
