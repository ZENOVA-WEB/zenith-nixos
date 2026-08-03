{ config, pkgs, vars, ... }:

{
  time.timeZone = vars.timeZone;
  i18n.defaultLocale = vars.locale;
  systemd.oomd.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "net.core.default_qdisc" = "fq_codel";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };

  system.stateVersion = "26.05";
}
