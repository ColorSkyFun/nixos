{ pkgs, ... }:
{
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        (qq.override {
          commandLineArgs = [
            "--disable-gpu"
            "--ozone-platform=wayland"
          ];
        })
        wechat
        telegram-desktop
      ];
    })
  ];
}
