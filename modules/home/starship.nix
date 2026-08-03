{ pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    
    settings = {
      add_newline = true;
      scan_timeout = 10;

      # Prompt Layout: Info on line 1, Prompt symbol on line 2
      format = lib.concatStrings [
        "$os"
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$git_state"
        "$nix_shell"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        "$python"
        "$cmd_duration"
        "$status"
        "$line_break"
        "$sudo"
        "$character"
      ];

      # Superuser / User indicator
      username = {
        style_user = "bold bright-blue";
        style_root = "bold bright-red bg:0x282a36";
        format = "[$user]($style)";
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format = "@[$hostname]($style) ";
        style = "bold bright-magenta";
      };

      # NixOS / OS Icon
      os = {
        disabled = false;
        style = "bold bright-cyan";
        symbols = {
          NixOS = "󱄅 ";
          Arch = "󰣇 ";
          Debian = "󰣚 ";
          Ubuntu = "󰕈 ";
          Linux = "󰌽 ";
        };
      };

      # Directory Smart Truncation
      directory = {
        style = "bold bright-cyan";
        truncation_length = 4;
        truncate_to_repo = true;
        read_only = " 󰌾";
        read_only_style = "red";
        format = "in [$path]($style)[$read_only]($read_only_style) ";
      };

      # Git Branch & Rich Status
      git_branch = {
        symbol = "󰘬 ";
        style = "bold bright-purple";
        format = "on [$symbol$branch]($style) ";
      };

      git_status = {
        style = "bold bright-yellow";
        format = "([$all_status$ahead_behind]($style) )";
        conflicted = "🏳 ";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?\${count}";
        stashed = "📦";
        modified = "!\${count}";
        staged = "+\${count}";
        renamed = "»\${count}";
        deleted = "✘\${count}";
      };

      # Nix Shell Indicator
      nix_shell = {
        symbol = "󱄅 ";
        style = "bold bright-blue";
        format = "via [$symbol$state( \\($name\\))]($style) ";
        impure_msg = "impure";
        pure_msg = "pure";
      };

      # Command Duration
      cmd_duration = {
        min_time = 2000;
        style = "bold yellow";
        format = "took [$duration]($style) ";
      };

      # Exit Code Status
      status = {
        disabled = false;
        symbol = "✘ ";
        style = "bold red";
        format = "[$symbol$common_meaning$signal_name$maybe_int]($style) ";
      };

      # Sudo Indicator
      sudo = {
        disabled = false;
        symbol = "⚡ ";
        style = "bold bright-red";
        format = "[$symbol]($style)";
      };

      # Prompt Character
      character = {
        success_symbol = "[❯](bold bright-green)";
        error_symbol = "[❯](bold bright-red)";
        vimcmd_symbol = "[❮](bold bright-yellow)";
      };

      # Runtimes
      nodejs = {
        symbol = " ";
        style = "bold bright-green";
        format = "via [$symbol($version)]($style) ";
      };
      python = {
        symbol = " ";
        style = "bold bright-yellow";
        format = "via [$symbol($version)]($style) ";
      };
      rust = {
        symbol = " ";
        style = "bold bright-red";
        format = "via [$symbol($version)]($style) ";
      };
      golang = {
        symbol = " ";
        style = "bold bright-cyan";
        format = "via [$symbol($version)]($style) ";
      };
      c = {
        symbol = " ";
        style = "bold blue";
        format = "via [$symbol($version)]($style) ";
      };
    };
  };
}
