{ pkgs, lib, ... }:

{
  home.packages = [
    pkgs.materia-theme
    pkgs.reversal-icon-theme
    pkgs.bibata-cursors
  ];

  home.sessionVariables = {
    GTK_THEME = lib.mkForce "Materia-dark";
    XCURSOR_THEME = lib.mkForce "Bibata-Modern-Classic";
    XCURSOR_SIZE = lib.mkForce "24";
  };

  gtk = {
    enable = true;
    theme = {
      name = lib.mkForce "Materia-dark";
      package = lib.mkForce pkgs.materia-theme;
    };
    iconTheme = {
      name = lib.mkForce "Reversal-dark";
      package = lib.mkForce pkgs.reversal-icon-theme;
    };
    cursorTheme = {
      name = lib.mkForce "Bibata-Modern-Classic";
      package = lib.mkForce pkgs.bibata-cursors;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Materia-dark";
      icon-theme = "Reversal-dark";
      cursor-theme = "Bibata-Modern-Classic";
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    enable = true;
    gtk.enable = true;
    x11.enable = true;
  };
}