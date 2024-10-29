{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Nix User Repository
    nur.url = "github:nix-community/NUR";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = { nixpkgs, home-manager, ... } @ inputs: 
  let 
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      darter-pro = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          username = "wingej0";
          hostname = "darter-pro";
        };
        modules = [
          ./hosts
        ];
      };
    };
    # homeConfigurations = {
    #   wingej0 = home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;
    #     modules = [ ./home.nix ];
    #   };
    # };
  };
}