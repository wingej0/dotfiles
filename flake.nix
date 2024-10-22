{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    # Cosmic desktop
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Qtile
    qtile-flake = {
      url = "github:qtile/qtile";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Qtile Extras
    qtile-extras-flake = {
      url = "github:elparaguayo/qtile-extras";
      flake = false;
    };
  };

  outputs = { nixpkgs, nur, home-manager, ... } @ inputs: 
  let 
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      darter-pro = lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts
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