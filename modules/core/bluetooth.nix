{ pkgs, vars, ... }:

{
  hardware.bluetooth.enable = vars.hasBluetooth;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = vars.hasBluetooth;
}
