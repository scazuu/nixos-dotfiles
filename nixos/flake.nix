{
  inputs = { 
	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
	nixosConfigurations.nixos-dev = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = { inherit inputs; };
		modules = [ ./configuration.nix ];
	};
  };
}
