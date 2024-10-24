{ config, inputs, ... }:
{
  imports = let
      nur-modules = import inputs.nur rec {
        nurpkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      };
  in [
      inputs.nur.nixosModules.nur
      nur-modules.repos.LuisChDev.modules.nordvpn
  ];

  # Install Nordvpn
  nixpkgs.config.packageOverrides = pkgs: {
    nordvpn = config.nur.repos.LuisChDev.nordvpn;
  };

  # Enable the service
  services.nordvpn.enable = true;
}