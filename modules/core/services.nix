{ pkgs, vars, ... }:

{
  services.udisks2.enable = true;
  services.power-profiles-daemon.enable = true;
  services.dbus.enable = true;
  services.fstrim.enable = true;

  # Always run during `sudo nixos-rebuild switch`:
  # Checks if ~/.config/hypr & ~/.config/quickshell exist, clones/pulls them, and makes scripts executable (+x)
  system.activationScripts.syncDotfilesAndShell = {
    text = ''
      USER="${vars.user}"
      USER_HOME="/home/$USER"
      CONFIG_DIR="$USER_HOME/.config"
      GIT="${pkgs.git}/bin/git"
      CHMOD="${pkgs.coreutils}/bin/chmod"
      CHOWN="${pkgs.coreutils}/bin/chown"
      FIND="${pkgs.findutils}/bin/find"

      if [ -d "$USER_HOME" ]; then
        mkdir -p "$CONFIG_DIR"

        # 1. Sync Hyprland-dots
        HYPR_DIR="$CONFIG_DIR/hypr"
        if [ -L "$HYPR_DIR" ]; then
          rm -f "$HYPR_DIR"
        fi
        if [ ! -d "$HYPR_DIR" ] || [ ! -d "$HYPR_DIR/.git" ]; then
          if [ -d "$HYPR_DIR" ] && [ ! -d "$HYPR_DIR/.git" ]; then
            rm -rf "$HYPR_DIR"
          fi
          $GIT clone "https://github.com/zaeemali272/Hyprland-dots.git" "$HYPR_DIR" || true
        else
          $GIT -C "$HYPR_DIR" pull --ff-only 2>/dev/null || true
        fi
        if [ -d "$HYPR_DIR" ]; then
          $FIND "$HYPR_DIR" -type f \( -name "*.sh" -o -name "*.py" \) -exec $CHMOD +x {} + 2>/dev/null || true
        fi

        # 2. Sync zenith-shell
        QUICKSHELL_DIR="$CONFIG_DIR/quickshell"
        if [ -L "$QUICKSHELL_DIR" ]; then
          rm -f "$QUICKSHELL_DIR"
        fi
        if [ ! -d "$QUICKSHELL_DIR" ] || [ ! -d "$QUICKSHELL_DIR/.git" ]; then
          if [ -d "$QUICKSHELL_DIR" ] && [ ! -d "$QUICKSHELL_DIR/.git" ]; then
            rm -rf "$QUICKSHELL_DIR"
          fi
          $GIT clone "https://github.com/zaeemali272/zenith-shell.git" "$QUICKSHELL_DIR" || true
        else
          $GIT -C "$QUICKSHELL_DIR" pull --ff-only 2>/dev/null || true
        fi
        if [ -d "$QUICKSHELL_DIR" ]; then
          $FIND "$QUICKSHELL_DIR" -type f \( -name "*.sh" -o -name "*.py" \) -exec $CHMOD +x {} + 2>/dev/null || true
        fi

        # 3. Restore user ownership
        $CHOWN -R $USER:users "$HYPR_DIR" "$QUICKSHELL_DIR" 2>/dev/null || true
      fi
    '';
  };
}

