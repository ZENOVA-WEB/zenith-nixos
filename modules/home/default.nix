{ pkgs, inputs, vars, config, ... }:

{
  imports = [
    ./bat.nix
    ./browser.nix
    ./btop.nix
    ./cava.nix
    ./direnv.nix
    ./gaming.nix
    ./git.nix
    ./gnome.nix
    ./gtk.nix
    ./hyprland/default.nix
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

  xdg.configFile."quickshell".source = config.lib.file.mkOutOfStoreSymlink "/home/${vars.user}/zenith-shell";
}
