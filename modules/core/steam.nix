{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;            # Open ports for Steam Remote Play
    dedicatedServer.openFirewall = true;       # Open ports for Source Dedicated Servers
    localNetworkGameTransfers.openFirewall = true; # Fast game transfers between local PCs
    
    # Optional: Automatically include custom compatibility tools like Proton-GE
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # Optional but highly recommended for gaming performance on NixOS
  programs.gamemode.enable = true;
}