{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome-2048
    scid-vs-pc
    stockfish
    lc0  
    zeroad
  ];
}