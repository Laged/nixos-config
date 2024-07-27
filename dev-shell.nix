{ pkgs, ... }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    bat-extras.batdiff
    bat
    eza
    git
    jq
    ripgrep
    vim
    zsh
  ];

  shellHook = ''
    # Apply home-manager configuration for the dev shell
    echo "Applying home-manager configuration..."
    home-manager switch --flake .#laged
    zsh
    echo "Development environment is ready!"
  '';
}
