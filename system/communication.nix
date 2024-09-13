{ config, pkgs, ... }:
{
  imports = [];

  environment.systemPackages = with pkgs; [
    # Communication
    telegram-desktop
    caprine-bin
    discord
    zoom-us
  ];
}