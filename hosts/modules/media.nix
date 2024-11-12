{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    obs-studio
    kdePackages.kdenlive
    mpv
    audacity
    gimp
    imagemagick
    libheif # For converting .heic images
    yt-dlp
    cider
    annotator
    ffmpeg
    loupe
  ];
}
