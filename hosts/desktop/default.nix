{ config, pkgs, vars, ... }:

{
  imports = [
    (if builtins.pathExists "/etc/nixos/hardware-configuration.nix"
     then /etc/nixos/hardware-configuration.nix
     else ./hardware-configuration.nix)
    ../../modules/core
  ];

  networking.hostName = vars.hostname;
}
