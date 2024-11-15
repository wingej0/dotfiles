{ config, pkgs, ...}:
{
    networking.hostName = "dis-winget"; # Define your hostname.
    networking.networkmanager.enable = true;

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [ 3389 27017 ];
    networking.firewall.allowedUDPPorts = [ 3389 27017 ];
}