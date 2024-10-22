{ config, pkgs, ... }:
{
  imports = [];

  # System76
  hardware.system76.enableAll = true;
  services.power-profiles-daemon.enable = false;

  environment.systemPackages = with pkgs; [
    # System76 Packages
    system76-firmware
  ];
}