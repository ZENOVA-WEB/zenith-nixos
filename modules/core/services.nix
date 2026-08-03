{ pkgs, ... }:

{
  services.udisks2.enable = true;
  services.power-profiles-daemon.enable = true;
  services.dbus.enable = true;
  services.fstrim.enable = true;
}

