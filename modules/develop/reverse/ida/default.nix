{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.callPackage (import ./ida.nix) { })
  ];
}
