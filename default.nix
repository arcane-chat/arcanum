{ nixpkgs ? ./pkgs.nix }:

with builtins;

let
  haskellOverlay = self: super: {
    haskell = super.haskell // {
      lib = super.haskell.lib // {
        docsFor = hp: pname: ((rec {
          ghcName = "${hp.ghc.system}-${hp.ghc.name}";
          package = hp.${pname};
          result = toPath "${package}/share/doc/${ghcName}/${package.name}/";
        }).result);
      };
    };

    haskellPackages = with self.haskell.lib; super.haskellPackages.override {
      overrides = self: super: {
        mighttpd2 = super.mighttpd2.overrideScope (self: super: {
          http-client_0_5_5 = super.http-client;
          http-client-tls_0_3_3_1 = super.http-client-tls;
          http-conduit_2_2_3 = super.http-conduit;
        });
      };
    };
  };

  pkgs = import nixpkgs {
    overlays = [ haskellOverlay ];
  };

  qt = pkgs.qt56;
in {
  arcanum = qt.callPackage ./arcanum.nix {};
  server = pkgs.callPackage ./server.nix {};
}
