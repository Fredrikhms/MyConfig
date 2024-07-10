# https://github.com/nix-community/NixOS-WSL/blob/main/docs/src/how-to/nix-flakes.md
# https://github.com/Misterio77/nix-starter-configs/blob/main/minimal/flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = {
    self, 
	nixpkgs, 
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
  };
}
