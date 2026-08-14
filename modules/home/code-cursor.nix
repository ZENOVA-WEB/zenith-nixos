{ pkgs, inputs, ... }:

{
  home.packages = [
    inputs.code-cursor-nix.packages.${pkgs.stdenv.hostPlatform.system}.cursor
  ];
}
