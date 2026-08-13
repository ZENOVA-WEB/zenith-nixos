{ pkgs, inputs, config, vars, lib, ... }:

{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  # Disable Home Manager hyprland.conf generator to prevent collision with out-of-store hypr directory link
  wayland.windowManager.hyprland.enable = lib.mkForce false;

  # Live out-of-store development symlinks pointing to local cloned repos.
  # This prevents NixOS from overriding or locking local user configuration files into read-only Nix store paths.
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