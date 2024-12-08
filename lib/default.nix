{
  lib,
  namespace,
  ...
}: {
  mkIfElse = p: yes: no:
    lib.mkMerge [
      (lib.mkIf p yes)
      (lib.mkIf (!p) no)
    ];

  # Access the (potentially nested) attribute in `set`
  # using a dot-delimited path `strPath`.
  # Evaluate to `null` when the attribute does not exist.
  #
  # `strPath`: A dot-delimited string
  # `set`: The attribute set to be accessed
  attrByStrPath = strPath: set:
    lib.attrsets.attrByPath
    (lib.strings.splitString "." strPath)
    null
    set;

  /*
  Helper function to make a module, only for use in
  modules/{nixos,home} because of some hardcodings.

  This function takes a file path (almost always should be ./.),
  options and config. Options and config will be passed verbatim
  to the module system.
  */
  # This entire function is horrible and I do not want to touch
  # it ever again
  mkModule = filePath: config: providedOpts: providedCfg: let
    # Extract the file path relative to the modules directory
    # eg. when called from modules/nixos/misc/test/default.nix
    # will produce ["misc" "test"]
    storePath = lib.path.splitRoot filePath;
    components = lib.path.subpath.components storePath.subpath;
    sub = lib.lists.sublist 5 9999 components;

    # Transform the list above into a nested attrset
    # eg. ["misc" "test"] will become {misc = {test = ...}}
    optsAttrset = lib.attrsets.setAttrByPath sub providedOpts;
    enabled = lib.${namespace}.attrByStrPath (lib.strings.concatStringsSep "." ([namespace] ++ sub ++ ["enable"])) config;
  in {
    options.${namespace} = optsAttrset;
    config = lib.mkIf enabled providedCfg;
  };
}
