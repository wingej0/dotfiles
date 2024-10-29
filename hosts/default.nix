{ hostname, ... }:
{
    imports = 
        if hostname == "darter-pro" then
            [
                # Configuration
                ./configuration.nix

                # Specialisations
                ./specialisations/cosmic.nix
                ./specialisations/gnome.nix
                ./specialisations/qtile.nix

                # Networking
                ./modules/networking.nix
                ./modules/nordvpn.nix

                # Packages
                ./modules/browsers.nix
                ./modules/communication.nix
                ./modules/development.nix
                ./modules/games.nix
                ./modules/input-remapper.nix
                ./modules/media.nix
                ./modules/office.nix
                ./modules/system.nix
                ./modules/system76.nix
                
                # Fonts
                ./modules/fonts.nix
                ./modules/msfonts.nix

                # Users
                ./modules/users.nix
            ]
        else
            [ ];
}