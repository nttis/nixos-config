{
  fetchFromSourcehut,

  heimdall-gui,
}:
heimdall-gui.overrideAttrs rec {
  version = "2.1.0";

  src = fetchFromSourcehut {
    owner = "~grimler";
    repo = "Heimdall";
    rev = "v${version}";
    sha256 = "sha256-4tOUVwcUGAEpZR+2QntYSaphUQUjXUbJCpZIQoHuLog=";
  };

  installPhase = ''
    mkdir -p $out/{bin,share/doc/heimdall,lib/udev/rules.d}
    install -m755 -t $out/bin bin/*
    install -m644 -t $out/lib/udev/rules.d  ../heimdall/60-heimdall.rules
  '';
}
