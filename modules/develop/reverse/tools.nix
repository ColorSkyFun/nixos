{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    android-tools
    ghidra
    rizin
    cutter
    cutterPlugins.rz-ghidra
    cutterPlugins.jsdec
  ];
}
