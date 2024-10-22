# This is necessary to use MS Fonts with OnlyOffice
# Follow the directions here: https://nixos.wiki/wiki/Onlyoffice

{ config, pkgs, lib, ... }:
{
    # Allow installation of unfree corefonts package
    nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "corefonts" "vistafonts" ];

    fonts.packages = with pkgs; [
        corefonts
        vistafonts
    ];
}