{ pkgs }:

pkgs.writeScript "combined" ''
    #!/usr/bin/env bash
    alias systemd-cat="${pkgs.systemd}/bin/systemd-cat"
    function arcanum-server { ${pkgs.arcanum.server} "$@"; }
    function arcanum-client { ${pkgs.arcanum.client}/bin/arcanum "$@"; }
    { arcanum-server |& systemd-cat -t arcanum-server; } &
    { arcanum-client |& systemd-cat -t arcanum-client; } &
    wait
''
