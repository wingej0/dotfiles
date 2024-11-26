{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        
        # Gnome extensions
        pkgs.gnome-tweaks
        gnomeExtensions.dash-to-dock
        gnomeExtensions.blur-my-shell
        gnomeExtensions.appindicator
        gnomeExtensions.caffeine
        gnomeExtensions.clipboard-indicator
        gnomeExtensions.alphabetical-app-grid
        gnomeExtensions.tiling-assistant
        gnomeExtensions.user-themes
        gnomeExtensions.gnordvpn-local

        gnome-calculator
        gnome-remote-desktop
    ];

    services.gnome.gnome-remote-desktop.enable = true;
}
