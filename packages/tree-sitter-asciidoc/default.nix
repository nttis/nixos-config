{pkgs, ...}:
pkgs.stdenv.mkDerivation rec {
  pname = "tree-sitter-asciidoc";
  version = "0.3.0";

  src = pkgs.fetchFromGitHub {
    owner = "cathaysia";
    repo = "tree-sitter-asciidoc";
    rev = "v${version}";
    hash = "sha256-7FLwOO8HgSxujMP/MifYiB3xghv6CWgYFnxkgu6yGNI=";
  };

  buildPhase = ''
    runHook preBuild
    $CC -shared -o asciidoc.so tree-sitter-asciidoc/src/*.c
    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out

    cp asciidoc.so $out/parser
    cp -r tree-sitter-asciidoc/queries $out/
  '';
}
