{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    frida-tools
  ];
}
