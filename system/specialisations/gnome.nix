{ config, pkgs, ... }:
{
    specialisation = {
        gnome-desktop.configuration = {
        services.xserver.displayManager.gdm.enable = true;
        services.xserver.desktopManager.gnome.enable = true;
        };
    };
}