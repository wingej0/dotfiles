{ config, pkgs, ... }:
{
  imports = [];

  # Enable networking
  networking.hostName = "darter-pro"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.wireguard.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    nordvpn = config.nur.repos.LuisChDev.nordvpn;
  };

  services.nordvpn.enable = true;

  # Open ports in the firewall.
  networking.firewall.checkReversePath = false;
  networking.firewall.allowedTCPPorts = [ 443 ];
  networking.firewall.allowedUDPPorts = [ 1194 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  environment.systemPackages = with pkgs; [
    
  ];
}