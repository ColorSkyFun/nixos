{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
  };
  home-manager.sharedModules = [
    (_: {
      programs.bash = {
        enable = true;
        initExtra =
          let
            theme = ./amro.omp.json;
          in
          ''
            eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init bash --config ${theme})"
            eval "$(${pkgs.direnv}/bin/direnv hook bash)"
            eval "$(${pkgs.fzf}/bin/fzf --bash)"
          '';
      };
    })
  ];
}
