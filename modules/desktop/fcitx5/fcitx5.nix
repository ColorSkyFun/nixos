{ pkgs, ... }:

{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-rime
      rime-wanxiang
      rime-cli
      librime-octagram
      librime-lua
      librime
    ];
    fcitx5.waylandFrontend = true;
  };

  home-manager.sharedModules = [
    (_: {
      i18n.inputMethod.fcitx5.themes."OriDark" = {
        theme = ./theme_OriDark/theme.conf;
        highlightImage = ./theme_OriDark/highlight.svg;
        panelImage = ./theme_OriDark/panel.svg;
      };
    })
  ];

}
