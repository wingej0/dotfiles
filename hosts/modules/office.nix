{ config, pkgs, ... }:
{
  imports = [];

  environment.systemPackages = with pkgs; [
    # Office
    gnome-text-editor
    obsidian
    onlyoffice-bin
    evince
    libreoffice-fresh
    planify
    mailspring
  ];
}