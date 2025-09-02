{ config, pkgs, ... }:

let
  # Wrap WinBox4 to force use of the XCB platform plugin under XWayland
  winbox4Wrapped = pkgs.winbox4.overrideAttrs (drv: rec {
    buildInputs = drv.buildInputs ++ [ pkgs.makeWrapper ];
    postFixup = ''
      wrapProgram $out/bin/WinBox \
        --set QT_QPA_PLATFORM xcb
    '';
  });
in {
  environment.systemPackages = with pkgs; [
    kitty
    neohtop
    mpv
    winbox4Wrapped
    bitwarden-desktop
    filezilla
    qbittorrent
    dbeaver-bin
    chromium
    firefox
    vesktop
    telegram-desktop
    nextcloud-talk-desktop
    nextcloud-client
    onlyoffice-desktopeditors
    rustdesk-flutter
    obsidian
  ];

  programs.amnezia-vpn.enable = true;

  # Nekoray
  programs.nekoray.tunMode.enable = true;
  programs.nekoray.enable = true;

  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableKvm = true;
  virtualisation.virtualbox.host.addNetworkInterface = false;
  users.extraGroups.vboxusers.members = [ "vs" ];
}
