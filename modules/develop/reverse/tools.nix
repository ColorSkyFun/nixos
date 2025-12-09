{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    android-tools
    detect-it-easy
    scrcpy
    ghidra
    rizin
    cutter
    cutterPlugins.rz-ghidra
    cutterPlugins.jsdec
  ];
}
