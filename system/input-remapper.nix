{ config, pkgs, ... }:
{
  imports = [];

  environment.systemPackages = with pkgs; [
    input-remapper
  ];

  services.input-remapper.enable = true;
}