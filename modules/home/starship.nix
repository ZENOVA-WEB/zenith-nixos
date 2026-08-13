{ pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    
    settings = {
      add_newline = false;
      scan_timeout = 10;

      # Complete Powerline Capsule Pill Layout
      format = lib.concatStrings [
        "$cmd_duration"
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
        "$java"
        "$lua"
        "$docker_context"
        "$memory_usage"
        "$time"
        "$battery"
        "$status"
        "$line_break"
        "$character"
      ];

      # Prompt Character
      character = {
        success_symbol = "[❯](bold bright-cyan)";
        error_symbol = "[❯](bold bright-red)";
        vimcmd_symbol = "[❮](bold bright-yellow)";
      };

      # OS Icon Capsule
      os = {
        disabled = false;
        style = "bg:bright-cyan fg:black";
        symbols = {
          NixOS = "󱄅 ";
          Arch = "󰣇 ";
          Debian = "󰣚 ";
          Ubuntu = "󰕈 ";
          Linux = "󰌽 ";
        };
        format = "[](bold fg:bright-cyan)[$symbol]($style)[](bold fg:bright-cyan) ";
      };

      # Username Capsule
      username = {
        style_user = "bg:cyan fg:black";
        style_root = "bg:red fg:black";
        format = "[](bold fg:cyan)[👤 $user]($style)[](bold fg:cyan) ";
        disabled = false;
        show_always = true;
      };

      # Hostname Capsule
      hostname = {
        ssh_only = false;
        style = "bg:blue fg:black";
        format = "[](bold fg:blue)[󰌢 $hostname]($style)[](bold fg:blue) ";
        trim_at = ".companyname.com";
        disabled = false;
      };

      # Directory Capsule & Substitutions
      directory = {
        home_symbol = "󰋜 ";
        read_only = " 󰌾";
        style = "bg:green fg:black";
        truncation_length = 6;
        truncation_symbol = "••/";
        format = "[](bold fg:green)[$path]($style)[](bold fg:green) ";
        substitutions = {
          "Desktop" = "󰧨 ";
          "Documents" = "󰈙 ";
          "Downloads" = "󰇚 ";
          "Music" = "󰎈 ";
          "Pictures" = "󰋩 ";
          "Videos" = "󰕧 ";
          "GitHub" = "󰊤 ";
        };
      };

      # Git Branch Capsule
      git_branch = {
        style = "bg:purple fg:black";
        symbol = "󰘬 ";
        truncation_length = 12;
        truncation_symbol = "";
        format = "[](bold fg:purple)[$symbol$branch(:$remote_branch)]($style)[](bold fg:purple) ";
      };

      git_commit = {
        commit_hash_length = 4;
        tag_symbol = "🏷 ";
      };

      git_state = {
        style = "bg:bright-yellow fg:black";
        format = "[](bold fg:bright-yellow)[\\($state( $progress_current of $progress_total)\\)]($style)[](bold fg:bright-yellow) ";
        cherry_pick = "🍒 PICKING";
      };

      git_status = {
        style = "bold fg:yellow";
        format = "([$all_status$ahead_behind]($style) )";
        conflicted = "🏳 ";
        ahead = "🏎💨 ";
        behind = "😰 ";
        diverged = "😵 ";
        untracked = "🤷 ";
        stashed = "📦 ";
        modified = "📝 ";
        staged = "[++\\($count\\)](green)";
        renamed = "✍️ ";
        deleted = "🗑 ";
      };

      # Command Duration Capsule
      cmd_duration = {
        min_time = 0;
        style = "bg:yellow fg:black";
        format = "[](bold fg:yellow)[󱎫 $duration]($style)[](bold fg:yellow) ";
      };

      # Nix Shell Capsule
      nix_shell = {
        symbol = "󱄅 ";
        style = "bg:bright-blue fg:black";
        format = "[](bold fg:bright-blue)[$symbol$state( \\($name\\))]($style)[](bold fg:bright-blue) ";
        impure_msg = "impure";
        pure_msg = "pure";
      };

      # Language & Runtime Capsules
      c = {
        symbol = " ";
        style = "bg:blue fg:black";
        format = "[](bold fg:blue)[$symbol($version)]($style)[](bold fg:blue) ";
      };

      rust = {
        symbol = " ";
        style = "bg:red fg:black";
        format = "[](bold fg:red)[$symbol($version)]($style)[](bold fg:red) ";
      };

      golang = {
        symbol = " ";
        style = "bg:cyan fg:black";
        format = "[](bold fg:cyan)[$symbol($version)]($style)[](bold fg:cyan) ";
      };

      nodejs = {
        symbol = " ";
        style = "bg:bright-green fg:black";
        format = "[](bold fg:bright-green)[$symbol($version)]($style)[](bold fg:bright-green) ";
      };

      python = {
        symbol = " ";
        style = "bg:yellow fg:black";
        format = "[](bold fg:yellow)[$symbol($version)]($style)[](bold fg:yellow) ";
      };

      java = {
        symbol = " ";
        style = "bg:red fg:black";
        format = "[](bold fg:red)[$symbol($version)]($style)[](bold fg:red) ";
      };

      lua = {
        symbol = " ";
        style = "bg:blue fg:black";
        format = "[](bold fg:blue)[$symbol($version)]($style)[](bold fg:blue) ";
      };

      # Infrastructure & System Capsules
      docker_context = {
        symbol = "󰡨 ";
        style = "bg:bright-blue fg:black";
        format = "[](bold fg:bright-blue)[$symbol$context]($style)[](bold fg:bright-blue) ";
      };

      memory_usage = {
        disabled = false;
        threshold = 75;
        style = "bg:magenta fg:black";
        symbol = "󰍛 ";
        format = "[](bold fg:magenta)[$symbol$ram]($style)[](bold fg:magenta) ";
      };

      time = {
        disabled = true;
        style = "bg:bright-purple fg:black";
        format = "[](bold fg:bright-purple)[󱑒 $time]($style)[](bold fg:bright-purple) ";
        time_format = "%T";
      };

      battery = {
        disabled = false;
        full_symbol = "󰁹 ";
        charging_symbol = "󰂄 ";
        discharging_symbol = "󰂃 ";
        display = [
          { threshold = 20; style = "bg:red fg:black"; }
          { threshold = 80; style = "bg:yellow fg:black"; }
          { threshold = 100; style = "bg:green fg:black"; }
        ];
        format = "[](bold fg:green)[$symbol$percentage]($style)[](bold fg:green) ";
      };

      status = {
        disabled = false;
        symbol = "✘ ";
        style = "bg:red fg:black";
        format = "[](bold fg:red)[$symbol$status]($style)[](bold fg:red) ";
      };

      # Other Module Toggles
      package.disabled = true;
      line_break.disabled = false;
    };
  };
}
