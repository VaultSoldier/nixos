{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clang
    gcc
    go
    nodejs
    python314Full
    uv
    sqlite
  ];
}
