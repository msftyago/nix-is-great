# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  /*  Define your hostname.  */
  networking.hostName = "nix";

  /*  Flakes.  */
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  /*  Configure network connections interactively with nmcli or nmtui.  */
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tashkent";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    #keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  /*  Enable sound with pipewire.  */
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    /* use the example session manager (no others are packaged yet so this is enabled by default,
     no need to redefine it in your config for now) */
    #media-session.enable = true;
  };


  /*  Enable the KDE Plasma6 Desktop Environment.  */
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  /*  Bluetooth Support.  */
  hardware.bluetooth.enable = true;      
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;  

  /*  Steam.  */
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;                 # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true;            # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true;  # Open ports in the firewall for Steam Local Network Game Transfers
  };
  
  /*  Oracle virtualbox.  */
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "yago" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.yago = {
     isNormalUser = true;
     shell = pkgs.fish;
     description = "Kamol Hakimov";
     extraGroups = [ "networkmanager" "wheel" ];
     packages = with pkgs; [
       /*  System Apps.  */
       kdePackages.kate
       telegram-desktop
       #nheko  #*INSECURE
       vlc
       spotify
       qbittorrent
       #libsForQt5.kamoso
       obs-studio          
       bluez
       bluez-experimental     
       libreoffice-qt6-still
       librewolf
       stellarium
       xplanet
       celestia
       gpredict
       obsidian      
       audacity
       gimp
       discord
       gparted
       anki
       protonvpn-gui
       vscode
       tealdeer
       xclip
       netcat
       openssl
       bat
       #gccgo14     
       virtualbox
       bottles 

       /*  Network tools.  */
       dig
       wireshark
       gns3-gui
       #ciscoPacketTracer7 

       /*  Audio programms.  */
       #lmms
       #ardour
       #guitarix
       yandex-music

       /*  Editors.  */
       #kicad
       #krita
       jetbrains-toolbox
       #blender
       #openscad
       codeblocks
      
       /*  Console programs.  */
       gnome-disk-utility 
       python312Packages.pip
       #libsForQt5.yakuake
       #pkgs.nerdfonts
       tree
       exfat
       ripgrep
       kitty
       gh
       starfetch
       ntfs3g  #this thing goes brrrr
       neofetch
     ];
   };

  /*  firefox.  */
  programs.firefox.enable = true;

  /*  fish.  */
  programs.fish.enable = true;

  /*  ALLOW_UNFREE  */
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
     vim
     wget
     fish
     neofetch
     btop
     lolcat
     lf
     cowsay
     wireshark
     git 
     nixd
     alejandra
     rust-analyzer
     nixpkgs-fmt
     emacs
     emacsPackages.doom
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  #services.emacs = {
  #enable = true;
  #package = inputs.doom-emacs.packages.${system}.doom-emacs.override {
  #  doomPrivateDir = ./doom.d;
  #  };
  #};

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

