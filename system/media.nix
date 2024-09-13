{ config, pkgs, ... }:
{
  imports = [];

  environment.systemPackages = with pkgs; [
    # Media
    obs-studio
    kdePackages.kdenlive
    mpv
    audacity
    gimp
    cider
    imagemagick
    libheif # For converting .heic images
    yt-dlp
  ];
}