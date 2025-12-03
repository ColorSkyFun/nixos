{ pkgs, ... }:
{
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        (microsoft-edge.override {
          commandLineArgs = [
            "--enable-features=UseOzonePlatform"
            "--ozone-platform=wayland"
            "--enable-features=WaylandWindowDecorations"
            "--ozone-platform-hint=wayland"
            "--enable-wayland-ime"
            "--enable-wayland-ime --wayland-text-input-version=3"
          ];
        })
        (google-chrome.override {
          commandLineArgs = [
            "--enable-features=UseOzonePlatform"
            "--ozone-platform=wayland"
            "--enable-features=WaylandWindowDecorations"
            "--ozone-platform-hint=wayland"
            "--enable-wayland-ime"
            "--enable-wayland-ime --wayland-text-input-version=3"
          ];
        })
      ];
    })
  ];
}
