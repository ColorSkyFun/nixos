{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jadx
  ];
}
