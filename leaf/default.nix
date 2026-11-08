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

  # Autostarts gnome polkit
  # Needed for apps that require sudo permissions (i.e. gnome-disks)
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Fonts
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.space-mono
  ];

  users.users.${config.username}.packages = with pkgs; [
    xdg-utils # needed for discord/vesktop to open web links in default browser
    usbutils
    coreutils
    acpi # Battery
    lm_sensors #
    brightnessctl
    bluez
    wirelesstools
    pipewire
    pulseaudio
    alsa-utils
    pamixer
    pavucontrol
    wl-clipboard
    glib
    gnome.nixos-gsettings-overrides # For gsettings theming
    jaq
    gojq
    socat
    ripgrep
    jq
    bc
    wlsunset
    unzip
    gvfs # for network file browsing
    dig
    libnotify
    p7zip
    #satty
    grim
    ddcutil
    ddcui
    cage # wayland compositor for greeter
  ];
}
