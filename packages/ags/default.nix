{
  inputs,
  pkgs,
  system,
  ...
}:
pkgs.stdenvNoCC.mkDerivation rec {
  name = "ags-shell";
  src = ./.;

  nativeBuildInputs = [
    inputs.ags.packages.${system}.default

    pkgs.wrapGAppsHook
    pkgs.gobject-introspection
  ];

  buildInputs = with inputs.astal.packages.${system}; [
    astal3
    io
  ];

  installPhase = ''
    mkdir -p $out/bin
    ags bundle app.ts $out/bin/${name}
  '';
}
