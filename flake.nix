{
  description = "My XMobar Wrapper";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-23.05;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      overlay = import ./overlay.nix;
    in flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let pkgs = import nixpkgs {
            inherit system;
            overlays = [overlay];
          };
          dynamicLibraries = with pkgs; [
            xorg.libX11
            xorg.libXrandr
            xorg.libXrender
            xorg.libXScrnSaver
            xorg.libXext
            xorg.libXft
            xorg.libXpm.out
            xorg.libXpm.dev
            xorg.libXrandr
            xorg.libXrender
          ];
      in rec {
        devShells.default = pkgs.haskellPackages.shellFor {
          packages = p: [ p.xmobar-solomon ];
          buildInputs = [
            pkgs.haskellPackages.cabal-install
            pkgs.haskellPackages.ghc
            pkgs.haskellPackages.haskell-language-server
            pkgs.pkg-config
          ] ++ dynamicLibraries;
        };
        packages.default = pkgs.haskellPackages.xmobar-solomon;
      }
    ) // { overlays.default = overlay; };
}
