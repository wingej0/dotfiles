{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # System Packages
    zsh
    git
    gh
    wget
    vim
    htop
    acpi
    killall
    fzf
    fastfetch
    wallust
    variety
    veracrypt
    remmina
    popsicle
    gparted
    file-roller
    bibata-cursors
    orchis-theme
    eza
    rclone
    yazi
    btop
    kitty
  ];
}