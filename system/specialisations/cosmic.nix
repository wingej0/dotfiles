{ config, pkgs, ... }:
{
    specialisation = {
        cosmic-desktop.configuration = {
            services.displayManager.cosmic-greeter.enable = true;
            services.desktopManager.cosmic.enable = true;

            environment.systemPackages = with pkgs; [
                # Gnome stuff
                gnome-online-accounts
                gnome-calendar
                geary
            ];

            programs.dconf.enable = true;
            services.gnome.evolution-data-server.enable = true;
            services.gnome.gnome-online-accounts.enable = true;
            services.gnome.gnome-keyring.enable = true;
        };
    };
}