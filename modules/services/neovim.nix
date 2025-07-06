{ config, pkgs, ... }:

{
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stylua
  ];

  environment.systemPackages = with pkgs; [
    neovim
    fd
    gcc
    lua5_1
    nodejs
    luarocks
    ripgrep
    fzf
  ];
}
