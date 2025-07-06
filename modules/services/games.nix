{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mangohud
    lutris
    osu-lazer
    prismlauncher
    nexusmods-app-unfree
    protontricks
    protonup-qt
  ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
}
