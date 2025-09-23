FROM archlinux:latest

# Update locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

# Update package repository
RUN pacman -Syu

# Install dev tools
RUN pacman -S --noconfirm git base-devel neovim zellij exa zoxide fd bat ripgrep stow rust nodejs go starship fzf wl-clipboard lazygit kubectl go-yq jq rsync man-db unzip plocate glibc python nodejs npm

# Use the host install of podman
RUN ln -s /usr/bin/distrobox-host-exec /usr/local/bin/podman
