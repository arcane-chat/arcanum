let
  pkgs = import <nixpkgs> { config = {}; };
  arcanum = pkgs.qt56.callPackage ./arcanum.nix {};
in {
  inherit arcanum;
}
