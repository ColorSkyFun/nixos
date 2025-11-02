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

    ../modules/develop/reverse/ida
    ../modules/develop/reverse/frida.nix
    ../modules/develop/reverse/jadx.nix
    ../modules/develop/reverse/tools.nix
    ../modules/develop/c.nix
    ../modules/develop/nix.nix
    ../modules/develop/python.nix
    ../modules/develop/rust.nix
    ../modules/develop/tools.nix

    ../modules/programs/browser.nix
    ../modules/programs/chat.nix
    ../modules/programs/editor.nix

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

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
}
