{ lib, config, pkgs, ... }:

{
  # Enable XDG MIME and menu support
  xdg.mime.enable = true;
  xdg.menus.enable = true;

  # quickshell
  qt.enable = true;

  # Fix for empty "Open With" menu in Dolphin when running under Hyprland
  # This copies the plasma-applications.menu file from plasma-workspace to /etc/xdg/menus/applications.menu
  environment.etc."/xdg/menus/applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  services = {
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;
    gnome.gnome-keyring.enable=true;
    blueman.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kde-gtk-config
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.sddm-kcm 
    kdePackages.ark
    libsForQt5.qt5.qtwayland
    qt5.qtwayland
    playerctl
    blueman 
    iwgtk
    dunst
    hyprlock
    wleave
    waybar
    libnotify
    rofi-wayland
    adwaita-qt
    kdePackages.discover

    # Hyprshot
    hyprshot
    grim
    slurp
    jq

    # Dolphin
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kdf
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.kio-admin
    kdePackages.qtwayland
    kdePackages.plasma-integration
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kdesdk-thumbnailers
    kdePackages.kimageformats
    kdePackages.ffmpegthumbs
    kdePackages.breeze-icons
    kdePackages.qtsvg
    kdePackages.kservice
    kdePackages.taglib
    shared-mime-info
    libappimage
    icoutils
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
