{
  description = "My XMobar Wrapper";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {inherit system;};
      xmobar-solomon = pkgs.haskellPackages.callCabal2nix "xmobar-solomon" (./.);
    in {
    defaultPackage.x86_64-linux =
      pkgs.haskellPackages.callPackage xmobar-solomon { };

    overlay = final: prev: {
      haskellPackages = prev.haskellPackages.override (old: {
        overrides = prev.lib.composeExtensions (old.overrides or (_: _: {}))
        (hself: hsuper: {
          xmobar = xmobar-solomon;
        });
      });
    };
  };
}
