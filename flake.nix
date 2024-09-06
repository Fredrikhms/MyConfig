{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.nixvim.url = "github:nix-community/nixvim";

  outputs = { self, nixpkgs, nixvim }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    let
      inherit pkgs nixvim;
      nvim = nixvim.legacyPackages.x86_64-linux.makeNixvim {
        plugins.lsp.enable = true;
      };
    in
    {
      systemPackages = [ nvim ];
      packages.x86_64-linux.default = pkgs.mkShell {
        packages = [
          #Shells  
          pkgs.fish
          #pkgs.zsh
          pkgs.nushell

          #Shell setup
          #pkgs.direnv pkgs.nix-direnv # https://tonyfinn.com/blog/nix-from-first-principles-flake-edition/nix-8-flakes-and-developer-environments/
          pkgs.any-nix-shell
          pkgs.starship # Nicer shell env
	  pkgs.chezmoi # Dotfiles handler

          # Shell tools
          pkgs.tmux # tmux + TmuxPackagManager  https://www.youtube.com/watch?v=DzNmUNvnB04
          pkgs.tmuxinator # Tmux session handler
          pkgs.byobu # Tmux client wrapper?
          pkgs.zoxide # smarter cd command, inspired by z and autojump (needs setup with nu)

          # Dev tools
          pkgs.git
          pkgs.helix
          pkgs.nano # Editor
          nvim
          pkgs.nil # Nix grammar
          pkgs.yq # Json query
          pkgs.jq # YAML query
          pkgs.jid
          pkgs.dos2unix
          pkgs.devenv
          pkgs.ripgrep

          # Fun 
          pkgs.newsboat # RSS reader

          #OLD
          # pkgs.nixFlakes # Flakes (remember to update ~/.config/nix/nix.conf) # https://yuanwang.ca/posts/getting-started-with-flakes.html
          # jetbrains.idea-community # idea-community 
        ];


        # This starts zsh.
        #shellHook = ''
        #   zsh && exit
        #  
        # any-nix-shell zsh --info-right | source /dev/stdin
        # eval "$(starship init zsh)"
        #   eval "$(zoxide init zsh)"
        #  
        #  " 
        #    '';


        shellHook = ''
          fish --init-command "
            any-nix-shell fish --info-right | source
            starship init fish | source
            #zoxide init fish | source
            set -gx EDITOR "hx"
            tmux set mouse on
          " && exit
        '';

      };
    };
}
