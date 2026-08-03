{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver  # Modern Intel GPUs (Broadwell / Gen 8 and newer)
      intel-vaapi-driver  # Older Intel GPUs (Fallback)
      vpl-gpu-rt          # Intel Quick Sync Video runtime for newer chips
    ];
  };
}