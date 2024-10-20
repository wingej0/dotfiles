{
  description = "Wingej0 OS - My Nix OS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Cosmic desktop
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Qtile and qtile-extras
    qtile-flake = {
      url = "github:qtile/qtile";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qtile-extras-flake = {
      url = "github:elparaguayo/qtile-extras";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, nixos-cosmic, qtile-flake, qtile-extras-flake, ... }:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      darter-pro = lib.nixosSystem {
        inherit system;
        modules = let
          nur-modules = import nur rec {
            nurpkgs = nixpkgs.legacyPackages.${system};
            pkgs = nixpkgs.legacyPackages.${system};
        };
        in [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          (_: { nixpkgs.overlays = [ qtile-flake.overlays.default ]; })
          nixos-cosmic.nixosModules.default
          ./configuration.nix
          nur.nixosModules.nur
          nur-modules.repos.LuisChDev.modules.nordvpn
        ];          
      };
    };
    homeConfigurations = {
      wingej0 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };
}
