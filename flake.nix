{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
   home-manager = {
     url = "github:nix-community/home-manager";
     inputs.nixpkgs.follows = "nixpkgs";
   };
  };

  outputs = {self, nixpkgs, nixos-wsl, home-manager }: {
    nixosConfigurations = {
      myNixOS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
	  nixos-wsl.nixosModules.wsl
        ];
      };
    };
   homeConfigurations = {
     myHome = home-manager.lib.homeManagerConfiguration {
       pkgs = import nixpkgs {
         system = "x86_64-linux";
         config.allowUnfree = true; # プロプライエタリなパッケージを許可
       };
       extraSpecialArgs = {
         inherit nixpkgs home-manager;
       };
       modules = [
         ./home.nix
       ];
     };
   };
  };
}
