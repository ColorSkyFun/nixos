{ lib, pkgs, ... }:
{
  # swaync is a notification daemon
  services.swaync = {
    enable = true;
  };
}
