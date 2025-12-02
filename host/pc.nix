{ inputs, pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../modules/core/boot.nix
    ../modules/core/fonts.nix
    ../modules/core/hardware.nix
    ../modules/core/nix-daemon.nix
    ../modules/core/prog.nix
    ../modules/core/video.nix

    ../modules/desktop/i18n.nix
    ../modules/desktop/mango
    ../modules/desktop/plasma.nix

    # ../modules/develop/reverse/ida
    ../modules/develop/reverse/frida.nix
    ../modules/develop/reverse/jadx.nix
    ../modules/develop/reverse/tools.nix
    ../modules/develop/c.nix
    ../modules/develop/nix.nix
    ../modules/develop/python.nix
    ../modules/develop/rust.nix
    ../modules/develop/tools.nix

    ../modules/programs/cli/bash/shell.nix
    ../modules/programs/cli/fastfetch/fastfetch.nix
    ../modules/programs/browser.nix
    ../modules/programs/chat.nix
    ../modules/programs/editor.nix
    ../modules/programs/office.nix

    ../modules/vm/kvm.nix

    ./hardware-configuration.nix
    ./wine.nix
  ];

  networking.hostName = "color";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "zh_CN.UTF-8";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.sky = {
      programs.home-manager.enable = true;
      home = {
        username = "sky";
        homeDirectory = "/home/sky";
        stateVersion = "25.11";
      };
    };
  };

  users.users.sky = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "libvirtd"
    ];

    packages = with pkgs; [
      oh-my-posh
      parted
      fastfetch
      nmap
      zip
      unzip
      xz
      p7zip
      unrar
      vlc
      ffmpeg
      wechat
      telegram-desktop
      fuse
      fuse3
    ];
  };

  environment.systemPackages = [
    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
      pkgs.buildFHSEnv (
        base
        // {
          name = "fhs";
          targetPkgs =
            pkgs:
            # pkgs.buildFHSEnv 只提供一个最小的 FHS 环境，缺少很多常用软件所必须的基础包
            # 所以直接使用它很可能会报错
            #
            # pkgs.appimageTools 提供了大多数程序常用的基础包，所以我们可以直接用它来补充
            (base.targetPkgs pkgs)
            ++ (with pkgs; [
              pkg-config
              ncurses
              fuse
              # 如果你的 FHS 程序还有其他依赖，把它们添加在这里
            ]);
          profile = "export FHS=1";
          runScript = "bash";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
  ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
}
