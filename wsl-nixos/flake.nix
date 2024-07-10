# https://github.com/nix-community/NixOS-WSL/blob/main/docs/src/how-to/nix-flakes.md
# https://github.com/Misterio77/nix-starter-configs/blob/main/minimal/flake.nix
{
	
  description = "My new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	
    # Wsl
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
	
	# Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self, 
	nixpkgs, 
	home-manager,
	nixos-wsl, 
	... 
  } @ inputs: let
    inherit (self) outputs;
  in {
	# NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname (current "nixos")
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        system = "x86_64-linux";
        # > Our main nixos configuration file <
        modules = [
		  nixos-wsl.nixosModules.default
          {
			imports = [./nixos/configuration.nix];
            wsl.enable = true;
          }
        ] ;
      };
    };
	
	# Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "nixos@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [./home-manager/home.nix];
      };
    };
  };
}
