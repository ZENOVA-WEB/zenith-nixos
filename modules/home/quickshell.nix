{ pkgs, inputs, config, vars, lib, ... }:

{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  # Disable Home Manager hyprland.conf generator to prevent collision with out-of-store hypr directory link
  wayland.windowManager.hyprland.enable = lib.mkForce false;

  # Do NOT manage ~/.config/hypr or ~/.config/quickshell as read-only nix-store symlinks
  xdg.configFile."hypr".enable = false;
  xdg.configFile."quickshell".enable = false;

  # Home Manager activation script that runs during `sudo nixos-rebuild switch`:
  # Clones the repos directly into ~/.config/hypr and ~/.config/quickshell if absent,
  # or pulls the latest updates via git pull if already present.
  home.activation.syncDotfilesAndShell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    GIT="${pkgs.git}/bin/git"
    
    # 1. Sync Hyprland-dots into ~/.config/hypr
    HYPR_DIR="$HOME/.config/hypr"
    if [ -L "$HYPR_DIR" ]; then
      $DRY_RUN_CMD rm -f "$HYPR_DIR"
    fi
    if [ ! -d "$HYPR_DIR" ]; then
      $DRY_RUN_CMD $GIT clone "https://github.com/zaeemali272/Hyprland-dots.git" "$HYPR_DIR"
    else
      if [ -d "$HYPR_DIR/.git" ]; then
        $DRY_RUN_CMD $GIT -C "$HYPR_DIR" pull --ff-only 2>/dev/null || true
      fi
    fi

    # 2. Sync zenith-shell into ~/.config/quickshell
    QUICKSHELL_DIR="$HOME/.config/quickshell"
    if [ -L "$QUICKSHELL_DIR" ]; then
      $DRY_RUN_CMD rm -f "$QUICKSHELL_DIR"
    fi
    if [ ! -d "$QUICKSHELL_DIR" ]; then
      $DRY_RUN_CMD $GIT clone "https://github.com/zaeemali272/zenith-shell.git" "$QUICKSHELL_DIR"
    else
      if [ -d "$QUICKSHELL_DIR/.git" ]; then
        $DRY_RUN_CMD $GIT -C "$QUICKSHELL_DIR" pull --ff-only 2>/dev/null || true
      fi
    fi
  '';
}