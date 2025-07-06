{ pkgs, ... }:

{
  virtualisation = {
    containers.enable = true;
    containers.registries = {
      search = [ "docker.io" ];
    };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    podman-desktop
    podman-compose

    distrobox
  ];
}
