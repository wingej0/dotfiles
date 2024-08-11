{ config, pkgs, ... }:
{
    gtk = {
        enable = true;

        iconTheme = {
            name = "Tela-dark";
            package = pkgs.tela-icon-theme;
        };

        theme = {
            name = "Adwaita";
            package = pkgs.adw-gtk3;
        };

        cursorTheme = {
            name = "Bibata-Modern-Classic";
            package = pkgs.bibata-cursors;
        };
    };
}