{ config, lib, pkgs, ... }:

{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
   package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  nixpkgs.config.cudaSupport = true;

  # Containers passthrough
  hardware.nvidia-container-toolkit.enable = true;

  environment.systemPackages = with pkgs; [ btop ];
  nixpkgs.overlays = [
    (self: super: {
      btop = super.btop.override {
        cudaSupport = true;
      };
    })
  ];
}
