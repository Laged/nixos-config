{ modulesPath, pkgs, ... }:
{
  imports = [ (modulesPath + "/installer/netboot/netboot-minimal.nix") ];

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrOQfsYJpXD/AFAxtC5aQ+mTyE367IyEipqNz5seu/d"
  ];

  environment.systemPackages = with pkgs; [
    pkgs.eza
    pkgs.bat
    pkgs.bat-extras.batdiff
    vim
  ];
}
