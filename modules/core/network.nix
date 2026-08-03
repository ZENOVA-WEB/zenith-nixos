{ pkgs, ... }:

{
  networking.firewall.enable = true;
  networking.firewall.checkReversePath = false;  
  networking.networkmanager.enable = true;
}
