{pkgs, ...}:
pkgs.stdenv.mkDerivation (final: {
  pname = "tree-sitter-asciidoc";
  version = "0.3.0";

  src = pkgs.fetchFromGitHub {
    owner = "cathaysia";
    repo = "tree-sitter-asciidoc";
    rev = "v${final.version}";
    hash = "sha256-7FLwOO8HgSxujMP/MifYiB3xghv6CWgYFnxkgu6yGNI=";
  };

  buildPhase = ''
    runHook preBuild
    $CC -shared -o parser tree-sitter-asciidoc/src/*.c
    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out

    cp parser $out/parser
    cp -r tree-sitter-asciidoc/queries $out/
  '';
})
