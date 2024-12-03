{lib, ...}:
with lib; {
  mkIfElse = p: yes: no:
    mkMerge [
      (mkIf p yes)
      (mkIf (!p) no)
    ];
}
