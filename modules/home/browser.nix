{ pkgs, ... }:

{
  programs.brave = {
    enable = true;
  };

  # Browser flags to fix Intel Iris Xe / Wayland WebGL and video hardware acceleration bugs
  xdg.configFile."chromium-flags.conf".text = ''
    --ozone-platform-hint=auto
    --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer
    --use-gl=angle
    --use-angle=gl
    --disable-features=UseChromeOSDirectVideoDecoder
  '';

  xdg.configFile."brave-flags.conf".text = ''
    --ozone-platform-hint=auto
    --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer
    --use-gl=angle
    --use-angle=gl
    --disable-features=UseChromeOSDirectVideoDecoder
  '';

  xdg.configFile."chrome-flags.conf".text = ''
    --ozone-platform-hint=auto
    --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer
    --use-gl=angle
    --use-angle=gl
    --disable-features=UseChromeOSDirectVideoDecoder
  '';
}
