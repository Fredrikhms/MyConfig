FROM registry.fedoraproject.org/fedora:latest

# Update locale
#RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

# Install dev tools
#RUN sudo dnf install -y git neovim zoxide fd bat ripgrep stow fzf wl-clipboard rsync man-db unzip just

# Use the host install of podman
RUN ln -s /usr/bin/distrobox-host-exec /usr/local/bin/podman
