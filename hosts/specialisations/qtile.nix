{ config, pkgs, inputs, ... }:
{
    imports = [
        # These imports provide the latest git commit of Qtile.
        # If they are commented out, the release version will be installed.
        # (_: { nixpkgs.overlays = [ inputs.qtile-flake.overlays.default ]; })
        ./../overlays/qtile-extras-overlay.nix
    ];
    
    specialisation = {

        qtile-desktop.configuration = {
        
            # Enable Qtile
            services.displayManager.sddm.enable = true;
            services.xserver.windowManager.qtile = {
                enable = true;
                extraPackages = python3Packages: with python3Packages; [
                    qtile-extras
                ];
            };

            hardware.bluetooth.enable = true;
            services.udisks2.enable = true;
            services.gvfs.enable = true;
            
            environment.systemPackages = with pkgs; [
                pavucontrol
                python3 # Needed for update widget

                # Portals
                xdg-desktop-portal
                xdg-desktop-portal-wlr
                xdg-desktop-portal-gtk

                # Gnome stuff
                gnome-online-accounts
                gnome-calendar
                nautilus

                # Wayland Programs
                rofi-wayland
                grim
                slurp
                swappy
                wf-recorder
                zenity
                wl-clipboard
                cliphist
                swayidle
                swaylock-effects
                polkit_gnome
                wlogout
                ffmpeg
                wlr-randr
                dunst
                playerctl
                brightnessctl
                xwayland
                nwg-look

                # X11 Programs
                picom
                haskellPackages.greenclip
                numlockx
                flameshot
                betterlockscreen
                arandr
                peek
            ];

            programs.xwayland.enable = true;
            programs.dconf.enable = true;
            services.gnome.evolution-data-server.enable = true;
            services.gnome.gnome-online-accounts.enable = true;

            xdg.portal = {
                enable = true;
                config.common.default = "*";
                extraPortals = with pkgs; [
                    xdg-desktop-portal-wlr
                    xdg-desktop-portal-gtk
                ];
            };

            # Enable pam for swaylock, so it will actually unlock
            security.pam.services.swaylock = {};
            services.gnome.gnome-keyring.enable = true;

            environment.sessionVariables = {
                NIXOS_OZONE_WL = "1";
            };
        };
    };
}