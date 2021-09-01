let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in
  pkgs.haskell.packages.ghc8104.callPackage ./default.nix { }
