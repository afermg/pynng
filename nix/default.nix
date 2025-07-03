{
  lib,
  pkgs,
  python3Packages,
}:
let
  callPackage = lib.callPackageWith (pkgs // packages // python3Packages);
  packages = {
    pynng = callPackage ./pynng.nix { };
  };
in
packages
