{ pkgs }:

with builtins;

with rec {
  hp = pkgs.haskellPackages;

  exampleHTML = "${pkgs.haskell.lib.docsFor hp "mighttpd2"}/html/";

  user = "nobody";
  group = "nogroup";

  mightyConf = pkgs.writeText "server.conf" ''
      Port: 5678
      Host: 127.0.0.1
      Debug_Mode: Yes
      User: ${user}
      Group: ${group}
      Logging: No
      Index_File: index.html
      Index_Cgi: index.cgi
      Connection_Timeout: 30 # seconds
      Fd_Cache_Duration: 10 # seconds
      Service: 0
  '';

  mightyRoute = pkgs.writeText "server.route" ''
      [localhost]
      / -> ${exampleHTML}
  '';
};

pkgs.writeScript "server" ''
    #!/usr/bin/env bash
    source ${./misc/substitute}
    export MIGHTY_DIR="$(mktemp -q -d --tmpdir mighty.XXXXXX)/"
    if test -d "$MIGHTY_DIR"; then
        mkdir -p "$MIGHTY_DIR/etc"
        mkdir -p "$MIGHTY_DIR/status"
        trap 'rm -rf "$MIGHTY_DIR"; rm /tmp/mighty*' EXIT
        MIGHTY_CONF="$MIGHTY_DIR/etc/conf"
        MIGHTY_ROUTE="$MIGHTY_DIR/etc/route"
        cat ${mightyConf}  > "$MIGHTY_CONF"
        cat ${mightyRoute} > "$MIGHTY_ROUTE"
        substituteAllInPlace "$MIGHTY_CONF"
        substituteAllInPlace "$MIGHTY_ROUTE"
        ${hp.mighttpd2}/bin/mighty "$MIGHTY_CONF" "$MIGHTY_ROUTE"
    fi
''
