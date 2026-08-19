{
  inputs = { 
	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	caelestia-shell = {
		url = "github:caelestia-dots/shell";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, ... }@inputs: {
	nixosConfigurations.nixos-dev = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = { inherit inputs; };
		modules = [ ./configuration.nix ];
	};
  };
}
