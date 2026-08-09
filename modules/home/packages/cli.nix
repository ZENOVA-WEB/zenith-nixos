{ pkgs, ... }: { home.packages = with pkgs; [ ripgrep fd jq glances ncdu tree ]; }
