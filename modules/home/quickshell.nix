{ pkgs, inputs, ... }:

{
  programs.quickshell = {
    enable = true;
    # Explicitly link it to your flake input version
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}