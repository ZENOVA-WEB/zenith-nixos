{ pkgs, inputs, config, vars, lib, ... }:

{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  # Disable Home Manager hyprland.conf generator to prevent collision with out-of-store hypr directory link
  wayland.windowManager.hyprland.enable = lib.mkForce false;

  # Real-time out-of-store live development symlinks with flake input fallback
  xdg.configFile."quickshell".source = lib.mkForce (
    if builtins.pathExists "/home/${vars.user}/zenith/zenith-shell"
    then (config.lib.file.mkOutOfStoreSymlink "/home/${vars.user}/zenith/zenith-shell")
    else inputs.zenith-shell
  );

  xdg.configFile."hypr".source = lib.mkForce (
    if builtins.pathExists "/home/${vars.user}/zenith/Hyprland-dots"
    then (config.lib.file.mkOutOfStoreSymlink "/home/${vars.user}/zenith/Hyprland-dots")
    else inputs.hyprland-dots
  );
}