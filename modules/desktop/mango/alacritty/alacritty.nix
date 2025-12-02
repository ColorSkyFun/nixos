{ pkgs, ... }:
{

  home-manager.sharedModules = [
    (_: {
      packages = [
        pkgs.alacritty
      ];
      programs.alacritty = {
        enable = true;
      };
      xdg.configFile."nixpkgs/config.nix".source = ./alacritty.toml;
    })
  ];
}
