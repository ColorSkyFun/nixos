{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    qqmusic
  ];
}
