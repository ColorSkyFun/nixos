{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
  };
  environment.systemPackages = with pkgs; [
    screen
  ];
}
