{ config, pkgs, ... }:
{
  imports = [];

  environment.systemPackages = with pkgs; [
    # System Packages
    zsh
    alacritty
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
    loupe
    file-roller
    virt-manager
    bibata-cursors
    orchis-theme
    eza
    distrobox
    rclone
    yazi
    btop
  ];
}