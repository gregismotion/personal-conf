{
  description = "thegergo02's personal configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";

    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:yaxitech/ragenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, agenix, ... }: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };
    
    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      thegergo02 = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "thegergo02";
        homeDirectory = "/home/thegergo02";
        configuration = {
          imports = [ ./users/thegergo02/home.nix ];
        };
      };
    };

    nixosConfigurations = {
      kyrios = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/kyrios/configuration.nix
          agenix.nixosModules.age
        ];
      };
      zeus = lib.nixosSystem {
        inherit system;
        modules = [ ./system/zeus/configuration.nix ];
      };
    };
  };
}
