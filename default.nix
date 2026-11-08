{...}: {
         
  config = {

    environment = {
      sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qtengine";
      XDG_SESSION_TYPE = "wayland";
    };

    # Power management
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
  };

}
