{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      packages.x86_64-linux.default = pkgs.mkShell {
        packages =  [
		  #Shells
		  pkgs.fish
          pkgs.zsh
          pkgs.nushell  
		
		  #Shell setup
          #pkgs.direnv pkgs.nix-direnv # https://tonyfinn.com/blog/nix-from-first-principles-flake-edition/nix-8-flakes-and-developer-environments/
		  pkgs.any-nix-shell 
          pkgs.starship # Nicer shell env
		  
		  # Shell tools
		  pkgs.tmux 	# tmux + TmuxPackagManager  https://www.youtube.com/watch?v=DzNmUNvnB04
          pkgs.zoxide 	# smarter cd command, inspired by z and autojump (needs setup with nu)
          
          # Dev tools
          pkgs.git
          pkgs.helix pkgs.nano pkgs.neovim # Editor
          pkgs.nil  	# Nix grammar
          pkgs.yq   	# Json query
		  pkgs.jq		# YAML query
		  pkgs.jid  
          pkgs.dos2unix 
		  pkgs.devenv
		  
		  # Fun 
		  pkgs.newsboat # RSS reader
		  
		  #OLD
          # pkgs.nixFlakes # Flakes (remember to update ~/.config/nix/nix.conf) # https://yuanwang.ca/posts/getting-started-with-flakes.html
          # jetbrains.idea-community # idea-community 
        ];
		
	
        # Note that `shellHook` still uses bash syntax.
        # This starts zsh, then exists the bash shell when fish exits.
		shellHook = ''
          zsh && exit
		#  
		#	any-nix-shell fish --info-right | source
		#	starship init fish | source
		#   eval "$(zoxide init zsh)"
		#  
		#  " 
        '';
		
		
        # Note that `shellHook` still uses bash syntax.
        # This starts fish, then exists the bash shell when fish exits.
        #shellHook = ''
        #  fish --init-command "
		#  
		#	any-nix-shell fish --info-right | source
		#	starship init fish | source
		#	zoxide init fish | source
		#  
		#  " && exit
        #'';
      };
    };
}
