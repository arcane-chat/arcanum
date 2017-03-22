{ stdenv, qmakeHook, makeQtWrapper
, qtbase, qtwebengine, qtwebchannel
}:

stdenv.mkDerivation {
  name = "arcanum";
  src = ./.;
  buildInputs = [ qmakeHook makeQtWrapper qtbase qtwebengine qtwebchannel ];
  QTWEBENGINEPROCESS_PATH = "${qtwebengine.out}/libexec";
}
