# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      #allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [ ];
  # programs.neovim.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = '' 
      set fish_greeting # Disable greeting
    '';
    plugins = [
      #{ name = "grc"; src = pkgs.fishPlugins.grc.src; }
      #{ name = "done"; src = pkgs.fishPlugins.done.src; }
      #{ name = "tide"; src = pkgs.fishPlugins.tide.src; }
      #{ name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
    ];
  };
  programs.tmux = {
    enable = true; #https://github.com/srid/nixos-config/blob/master/home/tmux.nix
    shortcut = "a";
    baseIndex = 1;
    # Stop tmux+eskace crazynes
    escapeTime = 0;
    # Force tmux to use /tmp for socets (WSL2 compat)
    secureSocket = false;
    plugins = [
      pkgs.tmuxPlugins.better-mouse-mode
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.copycat
      pkgs.tmuxPlugins.pain-control
      pkgs.tmuxPlugins.resurrect
      pkgs.tmuxPlugins.continuum
    ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.starship = {
    enable = true;
  };
  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Fredrik H. M. S.";
    userEmail = "fredrikhms@gmail.com";
  };

  #services.fail2ban.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
