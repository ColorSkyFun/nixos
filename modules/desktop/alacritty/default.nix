{ lib, ... }:
{
  home-manager.sharedModules = [
    (_: {
      programs.alacritty = {
        enable = true;
      };
      xdg.configFile."alacritty/alacritty.toml".source = lib.mkForce ./alacritty.toml;
    })
  ];
}
