{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      packages.x86_64-linux.default = pkgs.mkShell {
        packages =  [
          pkgs.fish
          pkgs.helix pkgs.nano pkgs.neovim # Editor
          pkgs.nil  # Nix grammar
          pkgs.yq pkgs.jq pkgs.jid  # Json and YAML
          pkgs.dos2unix # Tools
          pkgs.nushell  # Better shell
          pkgs.starship # Nicer shell env
          # pkgs.nixFlakes # Flakes (remember to update ~/.config/nix/nix.conf) # https://yuanwang.ca/posts/getting-started-with-flakes.html
          # any-nix-shell  
          # jetbrains.idea-community # idea-community 
          pkgs.zoxide # smarter cd command, inspired by z and autojump (needs setup with nu)
          pkgs.tmux # tmux + TmuxPackagManager  https://www.youtube.com/watch?v=DzNmUNvnB04
          pkgs.devenv
          #direnv nix-direnv # https://tonyfinn.com/blog/nix-from-first-principles-flake-edition/nix-8-flakes-and-developer-environments/
        ];
        # Note that `shellHook` still uses bash syntax.
        # This starts fish, then exists the bash shell when fish exits.
        #shellHook = ''
        #  fish && exit
        #'';
      };
    };
}
