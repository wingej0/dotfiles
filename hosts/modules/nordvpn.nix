{ config, pkgs, nur, ... }:
let 
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    nur-modules = import nur rec {
      nurpkgs = nixpkgs.legacyPackages.${system};
      pkgs = nixpkgs.legacyPackages.${system};
    };
in {
    imports = [
        nur.nixosModules.nur
        nur-modules.repos.LuisChDev.modules.nordvpn
    ];

    # Install Nordvpn
    nixpkgs.config.packageOverrides = pkgs: {
    nordvpn = config.nur.repos.LuisChDev.nordvpn;

    # Enable the service
    services.nordvpn.enable = true;
  };
}