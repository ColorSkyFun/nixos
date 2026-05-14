{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
  };
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        nil
        nixfmt
      ];
    })
  ];
}
