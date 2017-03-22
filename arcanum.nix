{ qtbase, qmakeHook, stdenv }:

stdenv.mkDerivation {
  name = "arcanum";
  src = ./.;
  buildInputs = [ qtbase qmakeHook ];
}
