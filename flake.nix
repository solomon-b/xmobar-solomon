{
  description = "My XMobar Wrapper";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
      let pkgs = import nixpkgs { system = "x86_64-linux"; };
          xmobar-solomon = pkgs.haskellPackages.callCabal2nix "xmobar-solomon" (./.);
      in pkgs.haskellPackages.callPackage xmobar-solomon { };

  };
}
