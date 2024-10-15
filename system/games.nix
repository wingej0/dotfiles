{ config, pkgs, ... }:
{
  imports = [];

  environment.systemPackages = with pkgs; [
    # Games
    gnome-2048
    scid-vs-pc
    stockfish
    lc0  
    zeroad
  ];
}