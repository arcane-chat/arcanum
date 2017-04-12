{ pkgs }:

with builtins;

with rec {
  nixpkgs = pkgs.path;
  x11Helpers = import (toPath "${nixpkgs}/nixos/tests/common/x11.nix");
  makeTest = import (toPath "${nixpkgs}/nixos/tests/make-test.nix");
};

makeTest ({ ... }:
  let
    testURL = "file://${pkgs.valgrind.doc}/share/doc/valgrind/html/index.html";
  in {
    name = "arcanum-test";

    machine = { config, ... }: {
      imports = [ x11Helpers ];
      environment.systemPackages = [ pkgs.arcanum.client pkgs.xdotool ];
    };

    testScript = ''
        # Wait until the X server starts
        $machine->waitForX;

        # Run Arcanum
        $machine->execute("xterm -e 'arcanum ${testURL}' &");

        # Wait until Arcanum has finished loading the page
        $machine->sleep(40);

        # Check that Arcanum is done
        $machine->succeed("xwininfo -root -tree | grep Done");

        # Take a screenshot
        $machine->screenshot("screen");
    '';
  }) {}
