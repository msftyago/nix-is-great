{
  description = "Nix is great! :]";
  # by @msftyago
  # 2026

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
  };

  # ---Inputs---
  inputs = {
    # Nixpkgs stable (Xantusia 25.11)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Nixpkgs unstable for rolling release
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # For hardware specific modifications
    hardware.url = "github:nixos/nixos-hardware";
    
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    outputs = {
      self,
      nixpkgs,
      nixpkgs-25_11,
      home-manager,
      ...
    } @ inputs: let
      inherit system;

      system = "x86_64-linux";
      


      pkgs = import nixpkgs {
        config = {
          allowUnfree = true;
        };
      };

    in {

    nixosConfigurations = {
      msft = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [ ./nixos/configuration.nix ];

      };
    };
  };
}
