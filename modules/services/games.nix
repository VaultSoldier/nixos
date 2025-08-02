{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mangohud
    lutris
    osu-lazer
    prismlauncher
    nexusmods-app-unfree
    protontricks
    protonplus
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
}
