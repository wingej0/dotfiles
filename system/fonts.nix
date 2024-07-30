{ config, pkgs, ... }:
{
    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        dejavu_fonts
        fira-code-nerdfont
        font-awesome
        corefonts
        vistafonts
    ];
}