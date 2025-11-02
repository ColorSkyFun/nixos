{ pkgs, ... }:
{
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        zed-editor
        (vscode.override {
          commandLineArgs = [
            "--enable-features=UseOzonePlatform"
            "--ozone-platform=wayland"
            "--enable-features=WaylandWindowDecorations"
            "--ozone-platform-hint=wayland"
            "--enable-wayland-ime"
            "--disable-gpu"
          ];
        })
        neovim
        obsidian
      ];
    })
  ];
}
