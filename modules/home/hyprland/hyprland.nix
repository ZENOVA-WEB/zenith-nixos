{ pkgs, ... }:
{
  home.packages = with pkgs; [
    awww
    grimblast
    hyprlock
    hyprpicker
    hyprshot
    hyprlauncher
    grim
    slurp
    wl-screenrec
    gpu-screen-recorder
    wl-clip-persist
    wl-clipboard
    cliphist
    wf-recorder
    glib
    wayland
    direnv
    tesseract
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    configType = "hyprlang";

    xwayland = {
      enable = true;
      # hidpi = true;
    };
    # enableNvidiaPatches = false;
    systemd.enable = true;
  };
}
