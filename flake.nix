{
  description = "Zenith - Universal Frost-Phoenix Style NixOS & Hyprland Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity-nix.url = "github:jacopone/antigravity-nix";
    hermes-agent.url = "github:NousResearch/hermes-agent";

    zenith-shell = {
      url = "git+file:///home/zaeem/zenith/zenith-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-dots = {
      url = "git+file:///home/zaeem/zenith/Hyprland-dots";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hermes-agent, zen-browser, antigravity-nix, ... }@inputs:
    let
      vars = import ./vars.nix;
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs vars; };
          modules = [
            hermes-agent.nixosModules.default
            ./hosts/desktop
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit inputs vars; };
              home-manager.users.${vars.user} = import ./modules/home/default.nix;
            }
          ];
        };
      };
    };
}