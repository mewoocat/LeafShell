{
  pkgs,
  inputs,
  ...
}: {
  programs.niri.enable = true;
  #programs.niri.package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default;

  # override to use config
  # Systemd unit override by added to nix artifiact like /nix/store/...-user-units/niri.service.d/overrides.conf
  systemd.user.services.niri = {
    environment = {
      NIRI_CONFIG = ./config/config.kdl;
    };
  };

  # systemctl status --user xdg-desktop-portal-gnome
  /*
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];
    config = {
      common.default = [ "kde" ];
    };
  };
  */

  environment = {
    systemPackages = with pkgs; [
      xwayland-satellite # For xwayland support in niri
    ];
  };

  /*
  hjem.users.eXia = {
    enable = true;
    files = {
      ".config/niri" = {
        #source = ./config;
        source = "/home/eXia/NixOS/modules/system/desktop-environments/leaf/niri/config/"; # For development
        clobber = true;
      };
    };
  };
  */
}
