{pkgs, ...}:
pkgs.stdenv.mkDerivation rec {
  pname = "tree-sitter-luau";
  version = "ec187cafba510cddac265329ca7831ec6f3b9955";

  src = pkgs.fetchFromGitHub {
    owner = "polychromatist";
    repo = "tree-sitter-luau";
    rev = version;
    hash = "sha256-a+TJFLt77G4UyvcLz5Nsc6gvsgCTwmpZDNyfN8YUJDc=";
  };

  buildPhase = ''
    runHook preBuild
    $CC -shared -o parser.so src/*.c
    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out

    cp parser.so $out/parser
    cp -r helix-queries $out/queries
  '';
}
