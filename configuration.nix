{ modulesPath, pkgs, ... }:

let
  homeManager = import <home-manager/nixos> { };
  devShell = import ./dev-shell.nix { inherit pkgs; };
  config = {
    username = "laged";
    email = "parkkila.matti@gmail.com";
    pub = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrOQfsYJpXD/AFAxtC5aQ+mTyE367IyEipqNz5seu/d";
  };
  version = "24.05"
in
{
  imports = [
    (modulesPath + "/installer/netboot/netboot-minimal.nix")
    homeManager.nixosModules.home-manager
  ];

  system.stateVersion = "24.05";
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "fi";
  };

  users.users.root.openssh.authorizedKeys.keys = [ pub ];
  users.users.laged = {
    isNormalUser = true;
    home = "/home/laged";
    initialPassword = "kek";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [ pub ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    eza
    bat
    bat-extras.batdiff
    bat-extras.batwatch
    vim
    zsh
    git
    home-manager
    networkmanager
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  services.networking.networkmanager.enable = true;
  services.openssh.enable = true;
}
