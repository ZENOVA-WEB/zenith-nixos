{ pkgs, vars, lib, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver  # Modern Intel GPUs (Broadwell / Gen 8 and newer)
      intel-vaapi-driver  # Older Intel GPUs (Fallback)
      vpl-gpu-rt          # Intel Quick Sync Video runtime for newer chips
      vulkan-loader
      mesa
    ];
  };

  environment.sessionVariables = lib.mkIf (vars.gpu == "intel") {
    LIBVA_DRIVER_NAME = "iHD";
  };
}