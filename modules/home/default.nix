{ pkgs, inputs, vars, config, ... }:

{
  imports = [
    inputs.zenith-shell.homeManagerModules.default
    inputs.hyprland-dots.homeManagerModules.default
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./direnv.nix
    ./fish.nix
    ./gaming.nix
    ./git.nix
    ./gnome.nix
    ./gtk.nix
    ./kitty.nix
    ./lazygit.nix
    ./micro.nix
    ./theme.nix
    ./obsidian.nix
    ./packages/default.nix
    ./quickshell.nix
    ./starship.nix
    ./zen.nix
    ./antigravity.nix
  ];

  home.username = vars.user;
  home.homeDirectory = "/home/${vars.user}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.hyprland-dots = {
    enable = true;
    devMode = true;
    devPath = "/home/${vars.user}/zenith/Hyprland-dots";
  };
}

