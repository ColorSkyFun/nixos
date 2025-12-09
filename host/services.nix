{ pkgs, lib, ... }:
{
  systemd.user.services.RunPythonHttpServer = {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    unitConfig.ConditionUser = "sky";
    description = "此服务会用python开启一个http server";
    serviceConfig = {
      Type = "simple";
      ExecStart =
        let
          python = pkgs.python312;
        in
        "${python}/bin/python -m http.server";
      WorkingDirectory = "/home/sky/workspace";
    };
  };
}
