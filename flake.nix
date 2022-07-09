{
  description = "thegergo02's personal configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zitadel = {
      url = "github:thegergo02/zitadel-prebuild-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # FIXME: hardcoded ssh config host
    keys = {
      flake = false;
      type = "git";
      url = "git+ssh://freeself_git/thegergo02/personal-keys";
    };
    secrets = {
      flake = false;
      type = "git";
      url = "git+ssh://freeself_git/thegergo02/personal-secrets";
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix, secrets, nixos-generators, zitadel, ... }@inputs: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [ zitadel.overlays.default ];
    };
    
    lib = nixpkgs.lib;

  in {
    # TODO: read dynamically
    homeManagerConfigurations = {
      thegergo02 = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "thegergo02";
        homeDirectory = "/home/thegergo02";
        configuration = {
          imports = [ ./users/thegergo02/home.nix ];
        };
      };
      root = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "root";
        homeDirectory = "/root";
        configuration = {
          imports = [ ./users/root/home.nix ];
        };
      };
    };

    nixosConfigurations = {
      installer = (lib.makeOverridable lib.nixosSystem) {
        inherit pkgs;
        specialArgs = { inherit inputs self; };
        modules = [
          ./system/installer/configuration.nix
          agenix.nixosModules.age
        ];
        #format = "iso";
      };
      kyrios = lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit inputs self; };
        modules = [
          ./system/kyrios/configuration.nix
          agenix.nixosModules.age
        ];
      };
      zeus = lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit inputs self; };
        modules = [ 
          ./system/zeus/configuration.nix
          agenix.nixosModules.age
        ];
      };
    };
  };
}
