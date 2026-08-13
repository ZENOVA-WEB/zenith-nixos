{ pkgs, ... }: {
  programs.kitty.enable = true;

  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
  '';

  xdg.dataFile."xfce4/helpers/kitty.desktop".text = ''
    [Desktop Entry]
    Version=1.0
    Icon=kitty
    Name=Kitty Terminal Emulator
    Type=X-XFCE-Helper
    X-XFCE-Category=TerminalEmulator
    X-XFCE-Commands=kitty
    X-XFCE-CommandsWithParameter=kitty --directory="%s"
  '';

  xdg.mimeApps = {
    enable = false;
  };
}

