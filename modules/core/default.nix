{ pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./bootloader.nix
    ./file-manager.nix
    ./fonts.nix
    ./hardware.nix
    ./hermes.nix
    ./network.nix
    ./nh.nix
    ./nixpkgs.nix
    ./piper.nix
    ./pipewire.nix
    ./program.nix
    ./security.nix
    ./services.nix
    ./steam.nix
    ./system.nix
    ./user.nix
    ./virtualization.nix
    ./wayland.nix
    ./xserver.nix
  ];
}
