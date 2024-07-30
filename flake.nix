{
  description = "Wingej0 OS - My Nix OS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }:
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
