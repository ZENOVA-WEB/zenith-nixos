{ pkgs, inputs, config, vars, ... }:

{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  # Real-time out-of-store live development symlinks
  xdg.configFile."quickshell".source = config.lib.file.mkOutOfStoreSymlink "/home/${vars.user}/zenith/zenith-shell";
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/${vars.user}/zenith/Hyprland-dots";
}