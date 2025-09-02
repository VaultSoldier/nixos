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

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
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
      lib = nixpkgs.lib;
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
          # caelestia deps
          {
            environment.systemPackages = with pkgs; [
              inputs.caelestia-cli.packages.${system}.default
              kdePackages.qtdeclarative
              kdePackages.kde-gtk-config
              kdePackages.breeze
              kdePackages.breeze-gtk
              nerd-fonts.caskaydia-cove
              papirus-icon-theme
              material-symbols
              gtk3
              lm_sensors
              ddcutil
              fish
              bluez
              swappy
              grim
              inotify-tools
              libqalculate
              wl-clipboard
              cliphist

              (quickshell.packages.${system}.default.withModules [
                pkgs.kdePackages.qtsvg
                pkgs.kdePackages.kirigami
              ])
              zen-browser.packages.${system}.default
            ];

            environment.sessionVariables.XDG_DATA_DIRS = lib.mkForce (
              "${pkgs.kdePackages.breeze}/share:"
              + "${pkgs.material-symbols}/share:"
              + "$XDG_DATA_DIRS"
            );
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
