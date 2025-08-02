{ config, pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  programs.tmux.enable = true;

  environment.systemPackages = with pkgs; [
    oh-my-posh
    git
    wget
    curl
    zoxide
    unzip
    unrar
    mc
    tealdeer
    xorg.xlsclients
    wineWowPackages.stable
    fwupd
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
