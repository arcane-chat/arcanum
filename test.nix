{ pkgs }:

with builtins;

with rec {
  nixpkgs = pkgs.path;
  x11Helpers = import (toPath "${nixpkgs}/nixos/tests/common/x11.nix");
  makeTest = import (toPath "${nixpkgs}/nixos/tests/make-test.nix");
};

makeTest ({ ... }:
  {
    name = "arcanum-test";

    machine = { config, ... }: {
      imports = [ x11Helpers ];
      environment.systemPackages = [ pkgs.xdotool ];
    };

    testScript = ''
        # Wait until the X server starts
        $machine->waitForX;

        # Run Arcanum
        $machine->execute("xterm -e '${pkgs.arcanum.combined}' &");

        # Wait until Arcanum has finished loading the page
        $machine->sleep(10);

        # Check that Arcanum is done
        # $machine->succeed("xwininfo -root -tree | grep Done");
        # $machine->execute("xdotool search --class arcanum");

        # Take a screenshot
        $machine->screenshot("initial");

        # Click on the link to the Haddock for Program.Mighty
        $machine->execute("xdotool mousemove 600 210");
        $machine->execute("xdotool click 1");
        $machine->execute("xdotool click 1");
        $machine->sleep(1);

        # Take a screenshot
        $machine->screenshot("afterMouse");

        # Tab over to the link for Program.Mighty.Route and press enter
        $machine->execute("xdotool key Tab");
        $machine->execute("xdotool key Tab");
        $machine->execute("xdotool key Tab");
        $machine->execute("xdotool key Tab");
        $machine->execute("xdotool key Tab");
        $machine->execute("xdotool key Tab");
        $machine->execute("xdotool key Tab");
        $machine->execute("xdotool key Tab");
        $machine->execute("xdotool key Return");
        $machine->sleep(1);

        # Take a final screenshot
        $machine->screenshot("afterKeyboard");
    '';
  }) {}
