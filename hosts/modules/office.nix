{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome-text-editor
    obsidian
    onlyoffice-bin
    evince
    libreoffice
    planify
    mailspring
  ];
}