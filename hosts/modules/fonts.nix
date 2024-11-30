{ config, pkgs, ... }:
{
    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        dejavu_fonts
        nerd-fonts.fira-code
        font-awesome
    ];
}