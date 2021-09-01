{ mkDerivation, base, font-awesome-type, lib, xmobar }:
mkDerivation {
  pname = "xmobar-solomon";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base font-awesome-type xmobar ];
  license = lib.licenses.asl20;
}
