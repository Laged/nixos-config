{ modulesPath, pkgs, ... }:
let
  pub = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrOQfsYJpXD/AFAxtC5aQ+mTyE367IyEipqNz5seu/d";
in
{
  imports = [ (modulesPath + "/installer/netboot/netboot-minimal.nix") ];
  system.stateVersion = "24.05";
  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "fi";
  };

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [ pub ];

  users.users.laged = {
    isNormalUser = true;
    home = "/home/laged";
    initialPassword = "kek";
    extraGroups = [
      "wheel"
      "networmanager"
    ];
    openssh.authorizedKeys.keys = [ pub ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    pkgs.eza
    pkgs.bat
    pkgs.bat-extras.batdiff
    vim
    zsh
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  services.networking.networkmanager.enable = true;
}
