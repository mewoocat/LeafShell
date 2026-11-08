{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./core-applications
    ./core-functions
    ./theming
    ./quickshell
    ./niri
    ./fonts.nix
    ./greeter
  ];

  # If an error occurs in any of the scripts here, the nixos-activation service will break
  system.userActivationScripts = {};
}
