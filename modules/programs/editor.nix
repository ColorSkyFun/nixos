{ inputs, pkgs, ... }:
{
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        zed-editor
        neovim
        obsidian
        inputs.llm-agents.packages.x86_64-linux.zcode
      ];
    })
  ];
}
