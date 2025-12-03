{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    android-tools
    scrcpy
    ghidra
    rizin
    cutter
    cutterPlugins.rz-ghidra
    cutterPlugins.jsdec
  ];
}
