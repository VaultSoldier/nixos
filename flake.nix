{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mikuboot = {
      url = "gitlab:evysgarden/mikuboot";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zen-browser, quickshell, mikuboot, ... } @ inputs:
    let
     system = "x86_64-linux";
     pkgs = import nixpkgs { inherit system; };
    in {
     nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;

        modules = [
          ./configuration.nix
          ./hosts/desktop/init.nix
          ./modules/shared.nix
          ./modules/hardware/nvidia.nix

          mikuboot.nixosModules.default
          
          # other modules...
          {
            environment.systemPackages = [
              quickshell.packages.${system}.default
              zen-browser.packages.${system}.default
            ];
          }
        ];
      };

     nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;

        modules = [
          ./configuration.nix
          ./hosts/laptop/init.nix
          ./modules/shared.nix
          ./modules/hardware/nvidia.nix

          mikuboot.nixosModules.default
          
          # other modules...
          {
            environment.systemPackages = [
              quickshell.packages.${system}.default
              zen-browser.packages.${system}.default
            ];
          }
        ];
      };
    };
}
