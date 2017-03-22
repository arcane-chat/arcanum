let
  pkgs = import <nixpkgs> { config = {}; };
  arcanum = pkgs.qt5.callPackage ./arcanum.nix {};
in {
  inherit arcanum;
}
