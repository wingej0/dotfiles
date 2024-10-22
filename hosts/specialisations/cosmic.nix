{ config, pkgs, inputs, ... }:
{
    imports = [
        {
            nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
        }
        inputs.nixos-cosmic.nixosModules.default
    ];

    specialisation = {
        cosmic-desktop.configuration = {
            services.displayManager.cosmic-greeter.enable = true;
            services.desktopManager.cosmic.enable = true;

            environment.systemPackages = with pkgs; [
                # Gnome stuff
                gnome-online-accounts
                gnome-calendar
            ];

            programs.dconf.enable = true;
            services.gnome.evolution-data-server.enable = true;
            services.gnome.gnome-online-accounts.enable = true;
            services.gnome.gnome-keyring.enable = true;
        };
    };
}