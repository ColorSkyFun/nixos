{
  inputs,
  pkgs,
  lib,
  ...
}:

let
  config = ./dotfiles/config.conf;
  bind = ./dotfiles/bind.conf;
  env = ./dotfiles/env.conf;
  rule = ./dotfiles/rule.conf;
  autostart = ./dotfiles/autostart.sh;
  wallpaper = ./res/wallpaper.png;
in
{
  imports = [
    inputs.mango.nixosModules.mango
  ];
  programs.mango.enable = true;

  home-manager.sharedModules = [
    (_: {
      imports = [
        inputs.mango.hmModules.mango

        ./swaync
        ./waybar
        ./wlogout
      ];

      home.packages = with pkgs; [
        alacritty
        obs-studio
        rofi
        xdg-desktop-portal-wlr
        swaybg
        waybar
        wl-clip-persist
        cliphist
        wl-clipboard
        sway-audio-idle-inhibit
        wlsunset
        pamixer
        swayidle
        brightnessctl
        swayosd
        wlr-randr
        grim
        matugen
        slurp
        satty
        wlogout
        sox
      ];

      wayland.windowManager.mango = {
        enable = true;
        settings = ''
          # config
          source=${config}

          # bind
          source=${bind}

          # env
          source=${env}

          # rule
          source=${rule}
        '';
        autostart_sh = ''
          ${lib.readFile autostart}
          # wallpaper
          swaybg -i ${wallpaper} >/dev/null 2>&1 &
        '';
      };
    })
  ];
}
