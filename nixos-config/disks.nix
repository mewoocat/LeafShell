{pkgs, ...}: {
  # Autostart the udiskie udisks2 frontend
  systemd.user.services.udiskie = {
    enable = true;
    after = ["graphical.target"];
    wantedBy = ["graphical.target"];
    description = "udiskie service";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.udiskie}/bin/udiskie'';
    };
  };
  # For udiskie automount to work
  services.udisks2.enable = true;
}
