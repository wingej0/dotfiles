{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        virt-manager
        distrobox
    ];

    # Virtualization
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    virtualisation.podman = {
        enable = true;
        dockerCompat = true;
    };
}