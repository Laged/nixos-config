{
  description = "Development environment with home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      devShell = import ./dev-shell.nix { inherit pkgs home-manager; };
    in
    {
      nixosConfigurations = lib.nixosSystem {
        dev = {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobakPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.laged = import ./home.nix;
            }
          ];
        };
      };

      devShells.${system}.default = devShell;

      homeConfigurations = {
        laged = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
}
