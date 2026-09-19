{ inputs, pkgs, ... }:
{
  home-manager.sharedModules = [
    (_: {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      wayland.windowManager.niri.xwaylandSatellitePackage = pkgs.xwayland-satellite;

      home.packages = with pkgs; [
        mpvpaper
        xwayland-satellite
        linux-wallpaperengine
      ];

      programs.noctalia = {
        enable = true;
        systemd.enable = true;

        settings = {
          # This may also be a string or path to a .toml file.
          theme = {
            mode = "dark";
            source = "builtin";
            builtin = "Catppuccin";
          };

          wallpaper = {
            enabled = true;
            default.path = "/home/sky/";
          };
        };
      };
    })
  ];
}
