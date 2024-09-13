{ config, pkgs, ... }:
{
  imports = [];

  # Install firefox.
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    # Browsers
    vivaldi
    brave
    google-chrome
  ];
}