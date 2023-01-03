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

  # Bootloader.
  boot = 
  {
    loader = 
    {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      timeout = 3;
    };
    # kernelPackages = linuxKernel.packages.linux_xanmod_stable.zfsUnstable;
    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable.zfs;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable.zfs;
  services.xserver.videoDrivers = [];

  ## NETWORKING ##
  networking =
  {
    hostName = "nixos";
    # hostName = "nixos"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager =
    {
      enable = true;
      dns = "dnsmasq";  # one of "default", "dnsmasq", "unbound", "systemd-resolved", "none"
      # enableStrongSwan = true;
    };

    ## WIREGUARD ##
    # wg-netmanager.enable = true;
    # wireguard =
    # {
    #   enable = true;
    #   interfaces = 
    #   {
    #     wg0 = {
    #       ips = [
    #         "192.168.20.4/24"
    #       ];
    #       peers = [
    #         {
    #           allowedIPs = [
    #             "192.168.20.1/32"
    #           ];
    #           endpoint = "demo.wireguard.io:12913";
    #           publicKey = "xTIBA5rboUvnH4htodjb6e697QjLERt1NAB4mZqp8Dg=";
    #         }
    #       ];
    #       privateKey = "yAnz5TF+lXXJte14tji3zlMNq+hd2rYUIgJBgB3fBmk=";
    #     };
    #   };
    # };

    # wg-quick.interfaces = 
    # {
    #   wg0 = {
    #     address = [
    #       "192.168.20.4/24"
    #     ];
    #     peers = [
    #       {
    #         allowedIPs = [
    #           "192.168.20.1/32"
    #         ];
    #         endpoint = "demo.wireguard.io:12913";
    #         publicKey = "xTIBA5rboUvnH4htodjb6e697QjLERt1NAB4mZqp8Dg=";
    #       }
    #     ];
    #     privateKey = "yAnz5TF+lXXJte14tji3zlMNq+hd2rYUIgJBgB3fBmk=";
    #   };
    # };

    # # RESOLVCONF 
    # useHostResolvConf = true;
    # resolvconf =
    # {
    #   enable = true;
    #   extraConfig = "libc=NO"; 
    #   useLocalResolver = true;
    # };
  };



  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = 
  {
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

  ### DESKTOP ENVIRONMENT ### 
  services.xserver = 
  {
    enable = true;

    # GNOME
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # # PANTHEON #
    # displayManager.lightdm.enable = true;
    # desktopManager = 
    # {
    #   pantheon = 
    #   {
    #     enable = true;
    #     debug = false;
    #     # extraWingpanelIndicators = "";
    #     # extraSwitchboardPlugs = "";
    #     # extraGSettingsOverrides = "";
    #     # extraGSettingsOverridePackages = "";
    #   };
    # };

    # # XFCE & QTILE
    # desktopManager = 
    # {
    #   default = "xfce";
    #   xfce =
    #   {
    #     enable = true;
    #     enableXfwm = false;
    #     noDesktop = true;
    #   };
    #   xterm.enable = true;
    # };
    # windowManager.qtile.enable = true;

    desktopManager.cinnamon.enable = false;
    desktopManager.mate.enable = false;
    desktopManager.xfce.enable = false;
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
  services = 
  {
    # ## PANTHEON DESKTOP ##
    # pantheon = 
    # {
    #   apps.enable = true;
    #   contractor.enable = false;
    # };

    # ## NEXTDNS ##
    # nextdns = 
    # {
    #   enable = true;
    #   # arguments = 
    #   # [ 
    #   #   "-config" 
    #   #     "149.112.112.112/20=quad9v4"
    #   # #   "108.162.192.0/18=abcdef"
    #   # #   "188.114.96.0/20=cfv4"
    #   # #   "2606:4700::/32=cfv6"
    #   # #   "2a06:98c0::/29=cfv6"
    #   # #   # "-cache-size" "10MB"
    #   # ];
    # };

    # ## ADGUARDHOME ##
    # adguardhome = 
    # {
    #   enable = true;
    #   openFirewall = true;
    #   settings =
    #   {
    #     dns =
    #     {
    #       bind_host = 
    #         # "1.1.1.1";
    #         "173.245.48.0";
    #     
    #       bind_port = "20";

    #       # query logging
    #       querylog_enabled = true;
    #       querylog_file_enabled = true;
    #       querylog_interval = "24h";
    #       querylog_size_memory = 1000;   # entries
    #       anonymize_client_ip = true;   # for now

    #       # adguard
    #       protection_enable = true;
    #       blocking_mode = "default";
    #       filtering_enable = true;

    #       # cloudflare DNS
    #       cloudflare.dns =
    #       [
    #         "1.1.1.1"
    #         "1.0.0.1"
    #       ];

    #       # caching
    #       cache_size = 536870912;  # 512 MB
    #       cache_ttl_min = 1800;    # 30 min
    #       cache_optimistic = true; # return stale and then refresh
    #     };
    #   };
    # };

    # ## DNSCRYPT-PROXY2 ##
    # dnscrypt-proxy2 =
    # {
    #   enable = true;
    #   upstreamDefaults = true;
    #   settings = 
    #   {
    #     sources.public-resolvers = {
    #       urls = [ "https://download.dnscrypt.info/resolvers-list/v2/public-resolvers.md" ];
    #       cache_file = "public-resolvers.md";
    #       minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
    #       refresh_delay = 72;
    #     };
    #   };
    # };

    # ## TOR ##
    # tor =
    # {
    #   enable = true;
    #   client.dns.enable = true;
    #   openFirewall = true;
    # };

    # ## CLOUDFLARE-CFDYNDNS ##
    # cfdyndns = 
    # {
    #   enable = true;
    #   email = "syifa.alfurqoni@gmail.com";
    #   apikeyFile = "https://api.cloudflare.com/client/v4";
    # };

    # ## cloudflare, custom, google, opendns, quad9
    # https-dns-proxy = 
    # {
    # enable = true;
    # provider.kind = "quad9";
    # # provider.url = "94.140.14.14";
    # # provider.ips = [
    # # "188.114.96.0/20"
    # # "173.245.48.0/20"
    # # "190.93.240.0/20"
    # # ];
    # };

    # ## RESOLVED ##
    # resolved =
    #   {
    #     enable = true;
    #     fallbackDns = 
    #     [
    #       # cloudflare
    #       "1.1.1.1"
    #       "1.0.0.1"
    #       # # quad9
    #       # "9.9.9.9"
    #       # "149.112.112.112"
    #       # # opendns
    #       # "208.67.222.222"
    #       # "208.67.220.220"
    #       # # adguarddns
    #       # "94.140.14.14"
    #       # "94.140.15.15"
    #       # # comodo secure dns
    #       # "8.26.56.26"
    #       # "8.20.247.20"
    #     ];
    #     domains =
    #     [
    #       # "https://doh-jp.blahdns.com/dns-query"
    #       # "https://dns.adguard-dns.com/dns-query"
    #     ];
    #   };
  };


  ## USERS ##

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = 
  {
    users.alfurqani = 
    { isNormalUser = true;
      description = "4LEND";
      extraGroups = [ "networkmanager" "wheel" ];
    };
    # Default Shells
    defaultUserShell = pkgs.fish;
  };

  # packages = with pkgs; [
  # ];

  ### PROGRAMS CONFIGURATION ###

  virtualisation.docker =
  {
    enable = true;
  };

  programs = 
  {
  # ## PANTHEON ##
  # pantheon-tweaks.enable = true;

  ## ZSH ##
  zsh =
  {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting = 
    {
      enable = true;
      highlighters = 
      [
        "main"
      ];
    };
    autosuggestions =
    {
      enable = true;
      async = true;
      strategy = 
      [
	"history"
	"completion"
        "match_prev_cmd"
      ];
      # extraConfig = 
      # {
      #   "bindkey '\t'" = "autosuggest-accept";
      # };
    };
    # ohMyZsh =
    # {
    #   enable = true;
    # };
  };
   
  ## FISH ##
  fish = 
  {
    enable = true;
  }; 

  ## THEFUCK ##
  thefuck = 
  {
    enable = true;
    alias = "";
  };

  ## STARSHIP ##
  starship = 
  {
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

  # ## FZF ##
  # fzf =
  # {
  #   keybindings = true;
  #   fuzzyCompletion = true;
  # };

    ## TMUX ##
  tmux = 
  {
    enable = true;
    shortcut = "a";
    terminal = "screen-256color";
    clock24 = true; 
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    historyLimit = 10000;
    resizeAmount = 10;
    aggressiveResize = true;
    plugins = with pkgs.tmuxPlugins;
    [
      jump
      battery
      copycat
      vim-tmux-navigator
      vim-tmux-focus-events
      tmux-fzf
      tmux-thumbs
      yank
      cpu
      net-speed
      nord
      fpp
      cpu
      open
      tilish
      urlview
      sysstat
      sidebar
      copy-toolkit
      online-status
      prefix-highlight
      extrakto
    ];
    extraConfig = 
    ''
      set -g default-terminal "xterm-256color"
      set -g default-command  /run/current-system/sw/bin/fish
      set -g default-shell /run/current-system/sw/bin/fish

      # bind r source-file $HOME/.config/tmux/tmux.conf \; display "Reloaded!"
      bind r source-file /etc/tmux.conf \; display "Reloaded!"

      unbind % 
      unbind '"' 
      unbind c 

      # window
      bind-key Space new-window
      bind-key b new-window 
      bind-key i split-window -h
      bind-key h split-window -v

      # bind -t vi-copy y copy-pipe 'xclip -in -selection clipboard'

      # resizing pane
      bind -r C-k resize-pane -U 5
      bind -r C-j resize-pane -D 5
      bind -r C-h resize-pane -L 5
      bind -r C-l resize-pane -R 5

      ## no prefix
      # switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # switch window
      bind -n M-p previous-window
      bind -n M-n next-window

      # yank
      bind -n M-] paste-buffer
      bind -n M-[ copy-mode
    '';
  };

  # ## TMUX ##
  # tmux = {
  #   enable	= true;
  #   shortcut	= "a";
  #   terminal 	= "screen-256color";
  #   keyMode	= "vi";
  #   clock24 	= true;
  #   # extraConfig	= 
  #   # "
  #   #   set -g default-command /run/current-system/sw/bin/fish
  #   #   set -g default-shell /run/current-system/sw/bin/fish
  #   # ";
  #   plugins 	= with pkgs.tmuxPlugins; [
  #     jump
  #     battery
  #     copycat
  #     vim-tmux-navigator
  #     prefix-highlight
  #     tmux-fzf
  #     yank
  #     cpu
  #     net-speed
  #     nord
  #     ];
  # };

  ## NEOVIM ##
  neovim = {
    enable	= true;
    viAlias	= true;
    vimAlias	= true;
    defaultEditor = true;
    configure =
    {
      customRC = ''
        imap jj <Esc>
        set number
        set relativenumber
        syntax on
        inoremap jj <Esc>
      '';
      packages.myVimPackage = with pkgs.vimPlugins;
      {
        start = 
	[ 
	  nord-vim 
	  nord-nvim
	  # fugitive
	  # yuck-vim
	  # vim_current_word
	  # vim-lightline-coc
	  # vimoutliner
	  # tmuxline-vim
	  # cmp-cmdline-history
	  # bufferline-nvim
	  # nordic-nvim
	  # onenord-nvim
	]; 
      };
    };
  };

  ## GIT ##
  git = 
  {
    enable = true;
    # config = 
    # {
    #   git config --global user.name "Alfurqani";
    #   git config --global user.email "syifa.alfurqoni@gmail.com;"
    # };
  };

  ## AUTOJUMP ##
  autojump.enable = true;
  };

  ### FONTS ### 
    fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      nerdfonts
      nerd-font-patcher
      comic-mono
      comic-neue
      comic-relief
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      vistafonts
      helvetica-neue-lt-std
      victor-mono
      ibm-plex
      smiley-sans  # A condensed and oblique Chinese typeface seeking a visual balance between the humanist and the geometric
      lxgw-wenkai  # An open-source Chinese font derived from Fontworks' Klee One
      lexend  # A variable font family designed to aid in reading proficiency
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace	=  [ "ComicMono" ];
        sansSerif	=  [ "ComicMono" ];
        serif		=  [ "ComicMono" ];
	# emoji		=  [ "Material-Design-Icons" ];
        # monospace	=  [ "ComicRelief" ];
        # sansSerif	=  [ "ComicRelief" ];
        # serif		=  [ "ComicRelief" ];
      };
    };
  };


  ### PACKAGES ###
  environment = 
  {
    shellAliases = 
    {
      l		= "exa -1 -g -l --icons -s type";
      la	= "exa -1 -g -l --icons -s type -a";
      lt	= "exa -1 -g -l --icons -s type -T";
      lat	= "exa -1 -g -l --icons -s type -a -T";
      du	= "${pkgs.du-dust}/bin/dust";

      nbs	= "sudo nixos-rebuild switch";
      nbb	= "sudo nixos-rebuild build";
      nbt	= "sudo nixos-rebuild test";
      conix	= "sudo nvim /etc/nixos/configuration.nix";
      nc	= "nix-channel";
      ncl	= "nix-channel --list"; 
      nca	= "nix-channel --add";
      ncrm	= "nix-channel --remove";
      ncu	= "nix-channel --update";
      hb	= "home-manager build";
      hs	= "home-manager switch";
      hg	= "home-manager generations";

      tls	= "tmux list-sessions";
      tkls	= "tmux kill-session -t";
      kat	= "pkill -f tmux";
      tks	= "tmux kill-server";
      
      g		= "git";
      gs	= "git status";
      ge	= "git clone";
      gcg	= "git config --global";
      gc	= "git config";
      gcl	= "git config --list";
      gcgl	= "git config --global --list";
      ga	= "git add";
      gal	= "git add -A";
      gcm	= "git commit -m";
      gam	= "git commit -a -m";
      gsi	= "git switch";
      gco	= "git checkout";
      gr 	= "git remote";
      gra	= "git remote add";
      grmv	= "git remote remove";
      grv	= "git remote -v";
      gb	= "git branch";
      gbl	= "git branch --list";
      gp	= "git push -u";
      gl	= "git log";

      y		= "yt-dlp";
      yy	= "yt-dlp --ignore-config --extract-audio --audio-quality 0";
      c		= "cd";
      d		= "cd ..";
      v		= "vim";
      nv	= "nvim";
      p		= "spacevim";
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

    # EXCLUDE GNOME PACKAGE
    gnome.excludePackages = (with pkgs; 
    [
    gnome-photos
    gnome-tour
    ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    ]);

    # # EXCLUDE PANTHEON PACKAGE
    # pantheon.excludePackages = with pkgs.pantheon;
    # [
    #   elementary-sound-theme
    #   elementary-mail
    #   elementary-code
    #   elementary-tasks
    #   elementary-music
    #   elementary-videos
    #   elementary-photos
    #   elementary-camera
    #   elementary-wallpapers
    # ];

    systemPackages = with pkgs;
    [
      javaCup  dbus_java  maven  dotnet-sdk  dotnet-runtime  glib  lua  xdg-desktop-portal  xdg-desktop-portal-wlr  dbus  nodejs  yarn  jq  nim  nimble-unwrapped

      ascii
      atool
      audacious
      bat
      cargo
      cmatrix
      darktable
      dbus
      electron
      exa
      firewalld
      font-manager
      gnupg
      gparted
      input-remapper
      kitty-themes
      libsForQt5.dolphin
      libreoffice
      inkscape
      nomacs
      notepadqq
      okular
      onlyoffice-bin
      pcmanfm
      pfetch
      plank
      protonvpn-cli
      protonvpn-gui
      python310Packages.protonvpn-nm-lib
      qbittorrent
      shotwell
      simplenote
      steam
      subdl
      speedtest-cli
      standardnotes
      starship
      tdesktop
      trash-cli
      ueberzug
      unrar
      wpsoffice
      xorg.xkill

      # python
      python310Packages.dbus-python  
      python310Full    
      python310Packages.pip  
      python310Packages.urllib3
      python310Packages.types-urllib3
      python310Packages.soupsieve
      python310Packages.idna
      python310Packages.charset-normalizer
      python310Packages.certifi
      python310Packages.requests
      python310Packages.beautifulsoup4
      python310Packages.soupsieve

      # an
      hakuneko
      yacreader
      anime-downloader
      anup
      adl
      filebot
      nhentai
      HentaiAtHome

      # share
      opendrop

      # social
      discord
      whatsapp-for-linux
      rPackages.telegram
      mailspring
      headset
      giara
      slack

      # audio
      wireplumber
      easyeffects
      pipewire
      pipewire-media-session
      ffmpeg
      freac  boca

      # archiver
      archiver
      xarchiver
      fsarchiver
      zip

      # network
      adguardhome
      tor
      dnscrypt-proxy2
      openssl

      # media player
      mpv
      vlc
      cmus
      cava
      streamlink
      moc
      musikcube
      mp3blaster
      python310Packages.deemix  
      python310Packages.deezer-py  
      python310Packages.deezer-python  
      nuclear
      spotify
      spotify-tui
      librespot

      # terminal
      alacritty
      kitty
      tmux
      git
      ranger
      joshuto
      deer
      pistol
      terminal-typeracer
      vim
      page
      duf
      neovim-unwrapped
      spacevim
      nvimpager
      neovide
      uivonim
      z-lua
      peco
      autojump
      pazi
      fasd
      yank
      xsel
      xclip
      mov-cli
      vifm
      vifm-full
      wget
      # alternative man tools / unix documentation
      cheat  # Create and view interactive cheatsheets on the command-line
      cht-sh  # CLI client for cheat.sh, a community driven cheat sheet
      navi  # An interactive cheatsheet tool for the command-line and application launchers
      tldr  # Simplified and community-driven man pages
      tealdeer  # A very fast implementation of tldr in Rust

      # text editor
      geany
      obsidian
      vscode-with-extensions 

      # nix
      nix-index
      nix-prefetch
      nix-prefetch-hg
      nix-prefetch-git
      nix-prefetch-github
      nix-prefetch-scripts
      nix-prefetch-docker

      # browser
      firefox
      librewolf
      brave
      chromium
      tor-browser-bundle-bin
      google-chrome
      opera
      palemoon
      epiphany

      # downloader
      yt-dlp
      youtube-dl 
      ytmdl
      aria
      python310Packages.aria2p
      uget
      uget-integrator
      axel 
      downonspot  # A spotify downloader writter in rust
      spotdl  # Download your Spotify playlists and songs along with album art and metadata

      # usb bootable
      woeusb
      woeusb-ng
      etcher
      ventoy-bin
      unetbootin
      ntfs3g
      fd

      # # pantheon package
      # pantheon.switchboard
      # pantheon-tweaks
      # pantheon.wingpanel
      # pantheon.wingpanel-indicator-a11y
      # pantheon.wingpanel-with-indicators
      # pantheon.wingpanel-indicator-network

      # cinnamon package
      cinnamon.nemo

      # xfce package
      xfce.ristretto
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.tumbler

      # shell
      fish
      fishPlugins.bass
      zsh
      bashInteractive

      # configuration dotfiles
      home-manager
      rcm

      # terminal display system information
      btop
      htop
      neofetch
      bottom
      checkip
      freshfetch
      ipfetch
      hyfetch
      pridefetch

      # virtual machine
      anbox
      waydroid
      flatpak
      gnome.gnome-boxes
      vmware-workstation
      virtualbox
      qemu
      qemu_kvm
      qtemu
      # virtualboxWithExtpack
      libreelec-dvb-firmware
      kodi
      kodi-gbm
      kodi
      docker  
      docker-compose

      # appimage
      appimagekit
      appimage-run

      # kernel
      linuxKernel.packages.linux_xanmod_stable.zfsUnstable
    ];
  };


  # NIXPKGS CONFIG
  nixpkgs.config.permittedInsecurePackages = [
                "electron-12.2.3"  # etcher
		];

  nixpkgs.config = 
  {
  allowUnsupportedSystem = true;
  allowUnfree = true;
  allowBroken = true;
  };

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
   xdg.portal.wlr.enable = true;
   # xdg.portal.extraPortals =
   # {
   #   xdg-desktop-portal-xfce
   #   xdg-desktop-portal-gtk
   #   xdg-desktop-portal-kde
   # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  ### SYSTEM CONFIGURATION ## 
  system = 
  {
    stateVersion = "nixos-unstable"; # Did you read the comment?
    autoUpgrade = 
    { 
      enable = true;
      channel = "https://nixos.org/channels/nixpkgs-unstable";
    };
  };

  nix = 
  {
    sshServe = 
    {
      enable = true;
      keys = []; 
    };
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

}
