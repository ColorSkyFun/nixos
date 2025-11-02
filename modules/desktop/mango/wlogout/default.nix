{ config, pkgs, ... }:
let
  pngFiles = builtins.filter (file: builtins.match ".*\\.png" file != null) (
    builtins.attrNames (builtins.readDir ./icons)
  );
in
{
  # Copy .png files in the current directory to the wlogout configuration directory
  home.file = builtins.listToAttrs (
    builtins.map (pngFile: {
      name = "${config.xdg.configHome}/wlogout/icons/${pngFile}";
      value = {
        source = ./icons/${pngFile};
      };
    }) pngFiles
  );

  programs = {
    wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "swaylock -f -c 000000 &";
          text = "  Lock   ";
          keybind = "l";
        }
        {
          label = "logout";
          action = "mmsg -q";
          text = " Logout  ";
          keybind = "m";
        }
        {
          label = "shutdown";
          action = "shutdown -h now";
          text = "Shutdown ";
          keybind = "d";
        }
        {
          label = "reboot";
          action = "reboot";
          text = " Reboot  ";
          keybind = "r";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = " Suspend ";
          keybind = "s";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
        }
      ];
      style = ''
        window {
            font-family:
                Maple Mono NF CN,
                HYLeMiaoTiJ,
                CaskaydiaCove Nerd Font,
                monospace;
            font-size: 12pt;
            font-weight: bold;
            color: #f4dfcd;
            background-color: rgba(46, 42, 30, 0.69);
        }

        button {
            background-repeat: no-repeat;
            background-position: center;
            font-size: 40px;
            background-size: 60%;
            border: none;
            color: #d5b497;
            text-shadow: none;
            border-radius: 20px 20px 20px 20px;
            background-color: rgba(121, 81, 1, 0);
            margin-top: 120px;
            margin-bottom: 120px;
            transition:
                all 0.3s cubic-bezier(0.55, 0, 0.28, 1.682),
                box-shadow 0.5s ease-in;
        }

        button:hover {
            background-color: rgba(184, 149, 80, 0.3);
            background-size: 80%;
            transition:
                all 0.3s cubic-bezier(0.55, 0, 0.28, 1.682),
                box-shadow 0.5s ease-in;
        }

        #lock {
            background-image: image(url("./icons/lock.png"));
        }

        #logout {
            background-image: image(url("./icons/logout.png"));
        }

        #logout:hover {
            background-image: image(url("./icons/logout.png"));
        }

        #suspend {
            background-image: image(url("./icons/sleep.png"));
        }

        #shutdown {
            background-image: image(url("./icons/power.png"));
        }

        #reboot {
            background-image: image(url("./icons/restart.png"));
        }

        #hibernate {
            background-image: image(url("./icons/hibernate.png"));
        }
      '';
    };
  };
}
