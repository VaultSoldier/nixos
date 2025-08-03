{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  time.timeZone = "Asia/Yekaterinburg";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = ["ru_RU.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8"];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vs = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
    packages = with pkgs; [];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    nerd-fonts.jetbrains-mono
  ];

  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    os-prober
    ipset
    cryfs
    lm_sensors
    adw-gtk3
    xdg-user-dirs
    bibata-cursors
  ];

  security.sudo-rs = {
    enable = true;
    execWheelOnly = false;
  };
  
  services.udisks2.enable = true;
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.sessionVariables = {
    GTK_APPLICATION_PREFER_DARK_THEME = "1";
    GTK_THEME = "Adwaita:dark";
    NIXOS_OZONE_WL = "1";
    GOPATH="$HOME/.local/share/go";
  };      

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    xdgOpenUsePortal = true;
  };

  xdg.mime.defaultApplications = {
    "inode/directory" = "org.kde.dolphin.desktop";
    "x-scheme-handler/terminal" = "kitty.desktop";

    ### BROWSER ###
    # "text/html" = "app.zen_browser.zen.desktop";
    # "x-scheme-handler/http" = "app.zen_browser.zen.desktop";
    # "x-scheme-handler/https" = "app.zen_browser.zen.desktop";
    # "x-scheme-handler/about" = "app.zen_browser.zen.desktop";
    # "x-scheme-handler/unknown" = "app.zen_browser.zen.desktop";

    "x-scheme-handler/chrome" = "zen-beta.desktop";
    "x-scheme-handler/http" = "zen-beta.desktop";
    "x-scheme-handler/https" = "zen-beta.desktop";
    "application/x-extension-htm" = "zen-beta.desktop";
    "application/x-extension-html" = "zen-beta.desktop";
    "application/x-extension-shtml" = "zen-beta.desktop";
    "application/x-extension-xht" = "zen-beta.desktop";
    "application/x-extension-xhtml" = "zen-beta.desktop";
    "application/xhtml+xml" = "zen-beta.desktop";
    "text/html" = "zen-beta.desktop";

    ### ARCHIVES ###
    "application/zip" = "org.kde.ark.desktop";
    "application/x-compressed-tar" = "org.kde.ark.desktop";
    "application/x-bzip-compressed-tar" = "org.kde.ark.desktop";
    "application/x-xz-compressed-tar" = "org.kde.ark.desktop";
    "application/x-rar" = "org.kde.ark.desktop";
    "application/x-7z-compressed" = "org.kde.ark.desktop";
    
    ### Media Player ###
    "video/mp4" = "mpv.desktop";
    "video/x-matroska" = "mpv.desktop";
    "video/webm" = "mpv.desktop";
    "audio/mpeg" = "mpv.desktop";
    "audio/ogg" = "mpv.desktop";
    "audio/wav" = "mpv.desktop";
  }; 
}
