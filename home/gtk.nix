{ config, pkgs, ... }:
{
    gtk = {
        enable = true;

        iconTheme = {
            name = "Tela-dark";
            package = pkgs.tela-icon-theme;
        };

        theme = {
            name = "Orchis";
            package = pkgs.orchis-theme;
        };

        cursorTheme = {
            name = "Bibata-Modern-Classic";
            package = pkgs.bibata-cursors;
        };
    };
}