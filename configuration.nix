{ config, pkgs, ... }:

{
  imports =
    [
      ./hosts/desktop/hardware-configuration.nix
      ./modules/services/hyprland.nix
      ./modules/services/games.nix
      ./modules/services/kanata.nix
      ./modules/services/neovim.nix
      ./modules/services/podman.nix
      ./modules/packages/cli.nix
      ./modules/packages/gui.nix
      ./modules/packages/code.nix
    ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  boot = {
    plymouth = {
      enable = true;
      themePackages = [ pkgs.mikuboot ];
      theme = "mikuboot";
    };
    #loader.systemd-boot.enable = true;
    #loader.efi.canTouchEfiVariables = true;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders.
    loader.timeout = 0;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  services.resolved.enable = true;

  networking.wireless.iwd.settings = {
    IPv6 = {
      Enabled = true;
    };
    Settings = {
      AutoConnect = true;
    };
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

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.vs = {
    isNormalUser = true;
    createHome = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" "podman"];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.zsh;

  environment.sessionVariables = {
    GTK_APPLICATION_PREFER_DARK_THEME = "1";
    GTK_THEME = "Adwaita:dark";
    NIXOS_OZONE_WL = "1";
    GOPATH="$HOME/.local/share/go";
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
    cryfs
    lm_sensors
    adw-gtk3
    xdg-user-dirs
    wl-clipboard
    copyq
    oh-my-posh
    bibata-cursors
  ];

  security.sudo-rs = {
    enable = true;
    execWheelOnly = false;
  };

  programs.uwsm.enable = true;
  programs.zsh.enable = true;
  programs.tmux.enable = true;
  
  services.udisks2.enable = true;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    xdgOpenUsePortal = true;
  };

  xdg.mime.defaultApplications = {
    "inode/directory" = "org.kde.dolphin.desktop";
    "x-scheme-handler/terminal" = "kitty.desktop";

    # BROWSER
    "text/html" = "app.zen_browser.zen.desktop";
    "x-scheme-handler/http" = "app.zen_browser.zen.desktop";
    "x-scheme-handler/https" = "app.zen_browser.zen.desktop";
    "x-scheme-handler/about" = "app.zen_browser.zen.desktop";
    "x-scheme-handler/unknown" = "app.zen_browser.zen.desktop";

    # ARCHIVES
    "application/zip" = "org.kde.ark.desktop";
    "application/x-compressed-tar" = "org.kde.ark.desktop";
    "application/x-bzip-compressed-tar" = "org.kde.ark.desktop";
    "application/x-xz-compressed-tar" = "org.kde.ark.desktop";
    "application/x-rar" = "org.kde.ark.desktop";
    "application/x-7z-compressed" = "org.kde.ark.desktop";
  }; 

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  networking.firewall.allowedUDPPorts = [ 41641 ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
