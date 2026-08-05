{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (element-desktop.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
    })
    pear-desktop
    aria2
  ];
}

