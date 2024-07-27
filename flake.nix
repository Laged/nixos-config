{
  description = "Development environment with home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = lib.nixosSystem {
        dev = {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./configuration.nix ];
        };
      };

      homeConfigurations = {
        laged = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home.nix ];
        };
      };
    };
}
