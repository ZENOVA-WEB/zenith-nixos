{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
    '';
    loginShellInit = ''
      if test -z "$DISPLAY" -a -z "$WAYLAND_DISPLAY"
        if string match -q "*/tty1" (tty)
          exec start-hyprland
        end
      end
    '';
  };
  programs.dconf.enable = true;
}
