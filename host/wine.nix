{ pkgs, ... }:

{
  # 安装必要的包
  environment.systemPackages = with pkgs; [
    # Wine 相关
    wineWowPackages.stable
    winetricks
    bottles

    # 依赖项
    p7zip
    cabextract

    # 字体（重要！）
    corefonts
    vista-fonts
    wqy_microhei

    # 图形驱动
    vulkan-tools
    vulkan-loader
  ];

  # 系统设置
  system.activationScripts.ldso = ''
    mkdir -p /lib
    ln -sfn ${pkgs.glibc.out}/lib32 /lib/ld-linux.so.2
  '';
}
