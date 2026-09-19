{ inputs, pkgs, ... }:
{
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        zed-editor
        neovim
        obsidian
        inputs.llm-agents.packages.x86_64-linux.zcode
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
      ];
    })
  ];
}
