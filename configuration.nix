# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system/fonts.nix
      ./system/input-remapper.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Define the swap
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # 16GB
  }];

  networking.hostName = "darter-pro"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.wireguard.enable = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  specialisation = {
    gnome-desktop.configuration = {
      # Enable the GNOME Desktop Environment.
      services.xserver.displayManager.gdm.enable = true;
      services.xserver.desktopManager.gnome.enable = true;
    };
    qtile-desktop.configuration = {

      # Enable the GNOME Desktop Environment.
      services.xserver.displayManager.gdm.enable = true;
      services.xserver.desktopManager.gnome.enable = true;
      
      # Enable Qtile
      services.xserver.windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages: with python3Packages; [
          qtile-extras
        ];
      };

      hardware.bluetooth.enable = true;
      
      environment.systemPackages = with pkgs; [
        xfce.thunar
        pavucontrol
        bibata-cursors

        # Portals
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk

        # Wayland Programs
        rofi-wayland
        grim
        slurp
        swappy
        wl-clipboard
        cliphist
        swayidle
        swaylock-effects
        polkit_gnome
        wlogout
        wlr-randr
        dunst
        playerctl
        brightnessctl
        xwayland
        nwg-look

        # X11 Programs
        picom
        haskellPackages.greenclip
        numlockx
        flameshot
        betterlockscreen
        arandr
        peek
      ];

      programs.xwayland.enable = true;

      # Enable pam for swaylock, so it will actually unlock
      security.pam.services.swaylock = {};
      services.gnome.gnome-keyring.enable = true;

      environment.sessionVariables = {
        EDITOR = "vim";
        GTK_THEME = "Pop-dark";
        NIXOS_OZONE_WL = "1";
      };
    };

    cosmic-desktop.configuration = {

      # Enable cosmic
      services.displayManager.cosmic-greeter.enable = true;
      services.desktopManager.cosmic.enable = true;

    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wingej0 = {
    isNormalUser = true;
    description = "Jeff Winget";
    extraGroups = [ "networkmanager" "wheel" "adm" "nordvpn" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # System76
  hardware.system76.enableAll = true;
  services.power-profiles-daemon.enable = false;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System76 Packages
    system76-firmware

    # System Packages
    zsh
    alacritty
    git
    gh
    wget
    vim
    htop
    acpi
    killall
    fzf
    pika-backup
    fastfetch
    wallust
    variety
    veracrypt
    # bibata-cursors
    remmina
    popsicle
    gparted

    # Browsers
    vivaldi
    brave
    google-chrome

    # Development
    vscode-fhs
    jetbrains.pycharm-community
    mongodb-compass
    insomnia
    mongodb
    mongosh

    # Media
    obs-studio
    kdePackages.kdenlive
    mpv
    audacity
    gimp
    cider
    imagemagick
    libheif # For converting .heic images
    yt-dlp

    # Office
    gnome-text-editor
    obsidian
    onlyoffice-bin
    evince
    libreoffice-fresh
    planify
    thunderbird
    geary
    betterbird
    
    # Communication
    telegram-desktop
    caprine-bin
    discord
    zoom-us

    # Python Environment
    (python3.withPackages (ps: with ps; [
      requests
      pip
      numpy
      pandas
      jupyterlab
      pymongo
      matplotlib
    ]))

    # Games
    gnome-2048
    scid-vs-pc
    stockfish
    lc0  
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    nordvpn = config.nur.repos.LuisChDev.nordvpn;
  };

  # Change shell to zsh
  environment.shells = with pkgs; [zsh bash];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  system.activationScripts.binbash = {
    deps = [ "binsh" ];
    text = ''
         ln -s /bin/sh /bin/bash
    '';
  };

  # Enable mongodb
  services.mongodb = {
    enable = true;
    enableAuth = true;
    initialRootPassword = "mongodbroot";
    bind_ip = "0.0.0.0";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.nordvpn.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.checkReversePath = false;
  networking.firewall.allowedTCPPorts = [ 443 ];
  networking.firewall.allowedUDPPorts = [ 1194 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
