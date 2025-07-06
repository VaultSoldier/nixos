{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    zoxide
    unzip
    tealdeer
    xorg.xlsclients
    wineWowPackages.stable
    yt-dlp
    ffmpeg
    spicetify-cli
    speedtest-cli
    ncdu
    stow
    htop
    btop
    killall
    fastfetch
  ];
}
