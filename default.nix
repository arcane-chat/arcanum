{ nixpkgs ? ./pkgs.nix }:

let
  pkgs = import nixpkgs { config = {}; };
  qt = pkgs.qt56;
in {
  arcanum = qt.callPackage ./arcanum.nix {};
}
