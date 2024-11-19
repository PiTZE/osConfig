{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> {};
in
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tehran";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [pkgs.xterm];
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-connections
    loupe
    snapshot
  ]) ++ (with pkgs.gnome; [
    baobab
    eog
    simple-scan
    seahorse
    yelp
    tali
    epiphany
    geary
    evince
    gnome-characters
    totem # video player
    gnome-music
    gnome-terminal
    gnome-maps
    gnome-characters
    gnome-contacts
    gnome-weather
    gnome-calendar
    gnome-clocks
    gnome-font-viewer
    gnome-logs
    gnome-disk-utility
  ]);

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.pi = {
    isNormalUser = true;
    description = "Pi";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.nushell;
  };

  nixpkgs.config.allowUnfree = true;

  environment.etc."shells".text = '' 
  /run/current-system/sw/bin/sh
  /run/current-system/sw/bin/bash
  /run/current-system/sw/bin/nu
  '';

  environment.systemPackages = with pkgs; [
  emacs
  neovim
  wget
  curl
  git
  ripgrep
  fd
  gh
  ntfs3g
  nmap
  fzf
  zip
  unzip
  python3
  nmap
  file
  tldr
  btop
  fastfetch

  nekoray
  brave
  obsidian
  telegram-desktop
  gnome.gnome-tweaks
  papirus-icon-theme
  gnomeExtensions.just-perfection
  gnomeExtensions.appindicator
  qgnomeplatform
  qgnomeplatform-qt6
  adwaita-qt
  adwaita-qt6
  feh
  btop
  retroarch
  mpv
  gnome.dconf-editor
  gnome-extension-manager
  unstable.glamoroustoolkit
  ];
  
  fonts.packages = with pkgs; [
  cantarell-fonts
  meslo-lgs-nf
  jetbrains-mono
  ];

  system.stateVersion = "24.05";
}
