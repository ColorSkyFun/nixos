{ pkgs, lib, ... }:
{
  fonts = lib.mkForce {
    enableDefaultPackages = false;
    fontconfig.enable = true;
    fontDir.enable = true;
    packages = with pkgs; [
      maple-mono.NF-CN
      nerd-fonts.noto
      nerd-fonts.jetbrains-mono
      nerd-fonts.fantasque-sans-mono
      noto-fonts-color-emoji
      noto-fonts-emoji-blob-bin
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };
}
