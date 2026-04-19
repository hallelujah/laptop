# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
# Permanently enable Nix Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos-laptop"; # MUST match the flake output name

    time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";

# Add this inside your configuration.nix
  wsl = {
    enable = true;
    defaultUser = "hery";
    wslConf.interop.enabled = true;
    wslConf.interop.appendWindowsPath = true;
  };

# Link the WSLg Wayland socket to the location systemd expects
  systemd.tmpfiles.rules = [
    "L+ /run/user/1001/wayland-0 - - - - /mnt/wslg/runtime-dir/wayland-0"
      "L+ /run/user/1001/wayland-0.lock - - - - /mnt/wslg/runtime-dir/wayland-0.lock"
  ];

# Make sure your user is defined (you probably already have this)
  users.users.hery = {
    isNormalUser = true;
    uid = 1001;
    description = "Ramihajamalala Hery";
    extraGroups = [ "wheel" ]; # networkmanager doesn't work in WSL
      shell = pkgs.zsh;
  };

# Enable zsh globally
  programs.zsh.enable = true;

# Enable nix-ld so pre-compiled binaries work (like JetBrains Gateway)
  programs.nix-ld.enable = true;

# Provide common standard libraries that JetBrains and other dynamic binaries might need
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
      zlib
      fuse3
      icu
      nss
      openssl
      curl
      expat
      readline
  ];

# services.dbus = {
#   enable = true;
#   implementation = "broker";
# };
#
  services.openssh = {
    enable = true;
    ports = [ 8822 ];

# Recommended security settings:
    settings = {
      PasswordAuthentication = false; # Force SSH keys instead of passwords
        PermitRootLogin = "no";
    };
  };

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

