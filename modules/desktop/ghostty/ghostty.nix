{ ... }:
let
  shader = ./cursor.glsl;
in
{
  home-manager.sharedModules = [(_: {
    programs.ghostty = {
      enable = true;

      settings = {
        custom-shader = "${shader}";
        cursor-opacity = 1;

        font-size = 14;
        font-thicken = true;

        background-opacity = 0.92;
        background-blur = 20;

        theme = "Catppuccin Mocha";
        cursor-style = "bar";
        cursor-style-blink = true;

      };
    };
  })];
}
