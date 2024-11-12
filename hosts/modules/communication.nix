{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    telegram-desktop
    caprine-bin
    discord
    zoom-us
  ];
}