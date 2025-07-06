{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    go
    nodejs
    python3Full
    uv
    sqlite
  ];
}
