{ config, pkgs, ... }:
let
  username = "laged";
  email = "parkkila.matti@gmail.com";
  version = "24.05";
in
{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "${version}";
  home.packages = with pkgs; [
    pkgs.eza
    pkgs.bat
    pkgs.bat-extras.batdiff
  ];

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "${username}";
      userEmail = "${email}";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ls = "eza";
        ll = "eza --long";
        lt = "eza --long --tree --all";
        ltf = "eza --long --tree --level=3";
        cat = "bat";
        a = "bat -A";
        b = "batdiff";
        bs = "batdiff --staged";
        c = "clear";
        ga = "git add -A";
        gs = "git status";
        kc = "nix-build '<nixpkgs/nixos>' --arg configuration ./configuration.nix --attr config.system.build.kexecTree";
      };
    };
    vim = {
      enable = true;
      defaultEditor = true;
      settings = {
        relativenumber = true;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
      };
    };
  };
}
