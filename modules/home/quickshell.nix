{ pkgs, inputs, config, vars, lib, ... }:

{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  # Real-time out-of-store live development symlinks
  xdg.configFile."quickshell".source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink "/home/${vars.user}/zenith/zenith-shell");
  xdg.configFile."hypr".source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink "/home/${vars.user}/zenith/Hyprland-dots");
}