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
    # Replace the original winbox4 with the wrapped variant
    winbox4Wrapped
    bitwarden-desktop
    filezilla
    qbittorrent
    dbeaver-bin
    chromium
    vesktop
    nekoray
    telegram-desktop
    nextcloud-talk-desktop
    nextcloud-client
    onlyoffice-desktopeditors
    rustdesk-flutter
    obsidian
  ];
}
