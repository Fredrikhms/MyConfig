#!bin/bash

#NON flake
#https://github.com/nix-community/NixOS-WSL/releases/tag/2405.5.4
# Update version: sudo nix-channel --add https://nixos.org/channels/nixos-24.05 nixos
# sudo nix-channel --update
#sudo nixos-rebuild switch


sudo nixos-rebuild --flake .
