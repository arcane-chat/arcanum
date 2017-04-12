with rec {
  inherit (builtins) toPath;
  makeTest = import <nixpkgs/nixos/tests/make-test.nix>;
  commonDir = <nixpkgs/nixos/tests/common>;
};

makeTest ({ pkgs, ... }:
  let
    testURL = "file://${pkgs.valgrind.doc}/share/doc/valgrind/html/index.html";
  in {
    name = "arcanum-test";

    machine = { config, pkgs, ... }: {
      imports = [ (toPath ("${commonDir}/x11.nix")) ];
      environment.systemPackages = [ pkgs.firefox pkgs.xdotool ];
    };

    testScript = ''
        # Wait until the X server starts
        $machine->waitForX;

        # Run Firefox
        $machine->execute("xterm -e 'firefox ${testURL}' &");

        # Wait until Firefox has started
        $machine->waitForWindow(qr/Valgrind/);

        # Wait until Firefox has finished loading the page
        $machine->sleep(40);

        # Get rid of "default browser" dialog by pressing <space>
        $machine->execute("xdotool key space");

        # Wait until Firefox hides the "default browser" dialog
        $machine->sleep(2);

        # Open the developer tool panel
        $machine->execute("xdotool key F12");

        # Wait until Firefox draws the developer tool panel
        $machine->sleep(10);

        # Check that Firefox has successfully loaded the test page
        $machine->succeed("xwininfo -root -tree | grep Valgrind");

        # Take a screenshot
        $machine->screenshot("screen");
    '';
  })
