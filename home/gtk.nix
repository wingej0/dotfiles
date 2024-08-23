{ config, pkgs, ... }:
{
    gtk = {
        enable = true;

        iconTheme = {
            name = "Pop";
            package = pkgs.pop-icon-theme;
        };

        theme = {
            name = "Pop-dark";
            package = pkgs.pop-gtk-theme;
        };

        cursorTheme = {
            name = "Adwaita";
            # name = "Bibata-Modern-Classic";
            # package = pkgs.bibata-cursors;
        };
    };
}