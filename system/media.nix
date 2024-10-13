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
    imagemagick
    libheif # For converting .heic images
    yt-dlp
    cider
  ];
}
