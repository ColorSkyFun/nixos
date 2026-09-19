{ inputs, pkgs, ... }:
{
  programs.niri = {
    enable = true;
  };

  home-manager.sharedModules = [(_: {
    imports = [
      inputs.catppuccin.homeModules.catppuccin
    ];
    home.packages = with pkgs;[
      xdg-desktop-portal-wlr
      wl-clip-persist
      cliphist
      wl-clipboard
      sway-audio-idle-inhibit
      brightnessctl
      wlr-randr
      grim
      fuzzel
    ];
    programs = {
      obs-studio.enable = true;
    };
    # Cursor theme: catppuccin
    catppuccin = {
      enable = true;
      cursors = {
        accent = "sky";
        flavor = "mocha";
      };
      obs = {
        flavor = "mocha";
      };
    };
  })];
}
