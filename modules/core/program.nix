{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    loginShellInit = ''
      if test -z "$DISPLAY" -a "$TTY" = "/dev/tty1"
        exec start-hyprland >/dev/null 2>&1
      end
    '';
  };
  programs.dconf.enable = true;
}
