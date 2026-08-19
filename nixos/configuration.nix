{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Boot loader.
  boot.loader = {
	systemd-boot.enable = false;
	grub.enable = false;
	efi.canTouchEfiVariables = true;
	refind = {
		enable = true;
		maxGenerations = 10;
	};
  };

  # Kernel Settings.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernel.sysctl."fs.inotify.max_user_watches" = 524288; # to allow jdk's to read files without worrying about limits
  boot.kernelModules = [ "i2c-dev" ];

  # FileSystem Security.
  fileSystems."/boot".options = lib.mkForce [ "umask=0077" ];

  # Networking.
  networking.hostName = "nixos-dev";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # User Account.
  users.users.scazuu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  # On-Startup?
  hardware.graphics.enable = true;
  programs.hyprland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.gnome.gnome-keyring.enable = true; # applications logout fix
  security.pam.services.sddm.enableGnomeKeyring = true; # applications logout fix
  environment.variables.EDITOR = "nvim";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 3d";
  };
  programs.dconf.enable = true;
  xdg.portal = {
	enable = true;
	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	config = {
		common.default = [ "gtk" ];
		hyprland.default = [ "hyprland" "gtk" ];
	};
  };

  # List packages installed in system profile.
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
	fastfetch
	kitty
	gtk4
	kdePackages.dolphin
	kdePackages.kio-extras
	htop
	waybar
	wofi
	swww
	mako
	wireplumber
	ddcutil
	wlogout
	hyprlock
	hypridle
	neovim
	gvfs
	google-chrome
	spotify
	git
	vscode
	jetbrains.idea
	jdk21
	godot
	claude-code
  ];
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  # List services that you want to enable:
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
	modesetting.enable = true;
	open = true;
	nvidiaSettings = true;
	package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  environment.sessionVariables = {
	WLR_NO_HARDWARE_CURSORS = "1";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
  };

  services.greetd.enable = false;
  services.displayManager.sddm = {
	enable = true;
	wayland.enable = true;
  };

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
  system.stateVersion = "26.05"; # Did you read the comment?

}
