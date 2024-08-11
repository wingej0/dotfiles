{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        # Themes
        adw-gtk3
        
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

        gnome.gnome-boxes
        pkgs.gnome-calculator
    ];
}
