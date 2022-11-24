# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Default Shells
  users.defaultUserShell = pkgs.fish;

  # Bootloader.
  boot.loader = {
  systemd-boot.enable = true;
  efi.canTouchEfiVariables = true;
  efi.efiSysMountPoint = "/boot/efi";
  timeout = 2;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "dnsmasq";
  # services.resolved.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.utf8";
    LC_IDENTIFICATION = "id_ID.utf8";
    LC_MEASUREMENT = "id_ID.utf8";
    LC_MONETARY = "id_ID.utf8";
    LC_NAME = "id_ID.utf8";
    LC_NUMERIC = "id_ID.utf8";
    LC_PAPER = "id_ID.utf8";
    LC_TELEPHONE = "id_ID.utf8";
    LC_TIME = "id_ID.utf8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the MATE,PANTHEON,XFCE Desktop Environment.
  services.xserver = {
  enable = true;
  displayManager.lightdm.enable = false;
  desktopManager.pantheon.enable = false;

  ## CONFIGURE PANTHEON ##

  desktopManager.cinnamon.enable = false;
  desktopManager.mate.enable = false;
  desktopManager.xfce.enable = false;

  # THIS USING XFCE DE AND I3 WINDOW MANAGER
  # services.xserver = {
  #   enable = true;   
  #   desktopManager = {
  #     default = "xfce";
  #     xterm.enable = false;
  #     xfce = {
  #       enable = true;
  #       noDesktop = true;
  #       enableXfwm = false;
  #     };
  #   };
  #   windowManager.i3.enable = true;
  # };
  
  # GNOME
  displayManager.gdm.enable = true;
  desktopManager.gnome.enable = true;

  # PLASMA5
  displayManager.sddm.enable = false;
  desktopManager.plasma5.enable = false;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # systemWide = true;
    # wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  ### SERVICES ###
  services.nextdns = {
      enable = true;
      arguments = [ "-config" "10.0.3.0/24=abcdef" "-cache-size" "10MB" ];
      # arguments = [ "-config" "108.162.192.0/18=abcdef"];
  };

  # services.adguardhome = {
  # enable = true;
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alfurqani = {
    isNormalUser = true;
    description = "4LEND";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # packages = with pkgs; [
  # ];


  ### PROGRAMS CONFIGURATION ###

  ## FISH ## 
  # fishConfig = {
  #  bind \t accept-autosuggestion
  #  set fish_greeting
  #  };
   
  programs.fish = {
    enable = true;
    # shellInit	= fishConfig;
    shellAliases = {
      l	= "exa -1 -g -l --icons -s type";
      la	= "exa -1 -g -l --icons -s type -a";
      lt	= "exa -1 -g -l --icons -s type -T";
      lat	= "exa -1 -g -l --icons -s type -a -T";
      du	= "${pkgs.du-dust}/bin/dust";

      n		= "sudo nixos-rebuild switch";
      conix	= "sudo nvim /etc/nixos/configuration.nix";
      nc	= "nix-channel";
      ncl	= "nix-channel --list"; 
      nca	= "nix-channel --add";
      ncu	= "nix-channel --update";

      tls	= "tmux list-sessions";
      tkls	= "tmux kill-sessions -t";
      kat	= "pkill -f tmux";
      
      g		= "git";
      gs	= "git status";
      ge	= "git clone";
      gcg	= "git config --global";
      gc	= "git config";
      gcl	= "git config --list";
      gcgl	= "git config --global --list";
      ga	= "git add";
      gcm	= "git commit -m";
      gam	= "git commit -a -m";
      gsi	= "git switch";
      grv	= "git remote -v";
      gbl	= "git branch --list";
      gp	= "git push -u";
      gl	= "git log";

      y		= "yt-dlp";
      c		= "cd";
      d		= "cd ..";
      v		= "vim";
      nv	= "nvim";
      t 	= "tmux";
      e		= "exit";
      lv	= "lvim";
      sp	= "speedtest-cli";
      py	= "python";
      py3	= "python3";
      b		= "bat";
      cl	= "clear";
      s		= "sudo su";
      sd	= "sudo";
      mkd	= "mkdir";
      cpr	= "cp -r";
      rm	= "rm";
      rmf 	= "rm -rf"; 
      a		= "aria2c";
      vf	= "vifm";
      ra	= "ranger";
      pc	= "protonvpn-cli";
      nq	= "notepadqq";
      bs	= "bash";

      ud	= "udisksctl";
      udm	= "udisksctl mount -b";
      udmd	= "udisksctl unmount -b";
    };
  }; 

  ## STARSHIP ##
  programs.starship = {
    enable	= true;
    settings	= {
    add_newline = true;
    command_timeout = 1000;
    cmd_duration = {
      format = " [$duration]($style) ";
      style = "bold #EC7279";
      show_notifications = true;
    };
    nix_shell = {
      format = " [$symbol$state]($style) ";
    };
    battery = {
      full_symbol = "🔋 ";
      charging_symbol = "⚡️ ";
      discharging_symbol = "💀 ";
    };
    git_branch = {
      format = "[$symbol$branch]($style) ";
    };
    gcloud = {
      format = "[$symbol$active]($style) ";
    };
    };
  };

  ## ALACRITTY ##
  # programs.alacritty = {
  #   enable	= true;
  # };

  ## TMUX ##
  programs.tmux = {
    enable	= true;
    shortcut	= "a";
    terminal 	= "screen-256color";
    keyMode	= "vi";
    clock24 	= true;
    plugins 	= with pkgs.tmuxPlugins; [
      jump
      battery
      copycat
      vim-tmux-navigator
      prefix-highlight
      tmux-fzf
      yank
      cpu
      net-speed
      nord
      ];
  };

  ## NEOVIM ##
  programs.neovim = {
    enable	= true;
    viAlias	= true;
    vimAlias	= true;
    defaultEditor = true;
  };

  ## GIT ##
  programs.git = {
    enable = true;
    config = {
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  ### FONTS ### 
    fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      nerdfonts
      nerd-font-patcher
      comic-mono
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace	=  [ "ComicMono" ];
        sansSerif	=  [ "ComicMono" ];
        serif		=  [ "ComicMono" ];
	emoji		=  [ "Material-Design-Icons" ];
      };
    };
  };


  ### PACKAGES ###
  environment.systemPackages = with pkgs; [
  	
  	javaCup  dbus_java  maven  dotnet-sdk  dotnet-runtime  glib  lua  xdg-desktop-portal  xdg-desktop-portal-wlr  home-manager  dbus  python310Packages.dbus-python
  	
    adguardhome
    alacritty
    archiver
    aria
    ascii
    audacious
    bat
    brave
    bashInteractive
    btop
    cargo
    cargo-make
    cava
    chromium
    cinnamon.nemo
    cmus
    darktable
    dbus
    duf
    easyeffects
    electron
    etcher
    exa
    flatpak
    firefox
    fish
    firewalld
    geany
    git
    gnupg
    gnome.gnome-boxes
    google-chrome
    gparted
    home-manager
    htop
    input-remapper
    kitty
    kitty-themes
    libsForQt5.dolphin
    librewolf
    libreoffice
    inkscape
    mpv
    nix-index
    neofetch
    neovim
    nextdns
    nomacs
    notepadqq
    ntfs3g
    okular
    onlyoffice-bin
    pcmanfm
    palemoon
    pipewire
    pipewire-media-session
    plank
    persepolis
    protonvpn-cli
    protonvpn-gui
    python310Packages.protonvpn-nm-lib
    python310Packages.aria2p
    qbittorrent
    ranger
    rcm
    rPackages.telegram
    shotwell
    simplenote
    steam
    subdl
    speedtest-cli
    standardnotes
    starship
    tdesktop
    terminal-typeracer
    tmux
    tor
    tor-browser-bundle-bin
    trash-cli
    uget
    uget-integrator
    unrar
    vifm
    vifm-full
    vim
    vscode-with-extensions 
    ventoy-bin
    vlc
    wget
    whatsapp-for-linux
    wireplumber
    woeusb
    woeusb-ng
    wpsoffice
    xarchiver
    xfce.ristretto
    xfce.thunar
    xfce.thunar-archive-plugin
    xorg.xkill
    yt-dlp
    ytmdl
    zsh
 ];


  # NIXPKGS CONFIG
  nixpkgs.config.permittedInsecurePackages = [
                "electron-12.2.3"  # etcher
		];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
   services.flatpak.enable = true;
   xdg.portal.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # ## CLOUDFLARE-DYDNS ##
  # services.cloudflare-dyndns = {
  #   enable	= true;
  #   ipv4	= true;
  #   ipv6	= true;
  # }; 


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # system.stateVersion = "22.05"; # Did you read the comment?
}
