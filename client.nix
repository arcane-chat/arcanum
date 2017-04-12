{ stdenv, qmakeHook, makeQtWrapper
, qtbase, qtwebengine, qtwebchannel
}:

stdenv.mkDerivation {
  name = "arcanum";
  src = ./.;

  buildInputs = [ qmakeHook makeQtWrapper qtbase qtwebengine qtwebchannel ];

  postInstall = ''
      wrapQtProgram "$out/bin/arcanum" \
          --set "NIX_PROFILES" "" \
          --set "QTWEBENGINEPROCESS_PATH" "${qtwebengine.out}/libexec"
  '';

  NIX_PROFILES = "";
  QTWEBENGINEPROCESS_PATH = "${qtwebengine.out}/libexec";
}
