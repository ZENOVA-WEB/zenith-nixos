{ pkgs, ... }:

{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber = {
      enable = true;
      extraConfig.wireplumber = {
        "bluetooth.autoswitch-to-headset-profile" = false;
      };
    };
  };
}