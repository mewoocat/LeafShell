{
  config,
  pkgs,
  inputs,
  ...
}: let
  leaf-shell = pkgs.writeShellScriptBin "leaf-shell" ''
    pkill quickshell
    quickshell \
        --log-rules "*.debug=false;*.warning=false" \
        --path "${./config}" \
  '';

  leaf-shell-debug = pkgs.writeShellScriptBin "leaf-shell-debug" ''
    pkill quickshell
    quickshell \
        --path "${./config}"
  '';
in {
  users.users.${config.username}.packages = [
    # Startup scripts in user packages so the user level niri.service unit can resolve it
    leaf-shell
    leaf-shell-debug
  ];

  environment = {
    sessionVariables = {
      LEAF_QS_DIR = "${./config}";
    };
    systemPackages = with pkgs; [
      # Installing globally to appease qmlls
      # https://quickshell.outfoxxed.me/docs/configuration/getting-started/
      #inputs.quickshell.packages.${config.hostSystem}.default # Quickshell package
      # Overriding to add qml-niri plugin, apparently adding the plugin to the buildInputs works?
      /*
      (inputs.quickshell.packages.${config.hostSystem}.default.overrideAttrs (
        prevAttrs: {
          buildInputs = [
            inputs.qml-niri.packages.${config.hostSystem}.default
          ] ++ prevAttrs.buildInputs;
        }
      ))
      */
      (quickshell.overrideAttrs (
        prevAttrs: {
          buildInputs =
            [
              inputs.qml-niri.packages.${config.hostSystem}.default
            ]
            ++ prevAttrs.buildInputs;
        }
      ))

      kdePackages.qtdeclarative # Add qml types in path for qmlls
      kdePackages.qt5compat # For Qt5Compat.GraphicalEffects

      # For styling QtQuick controls within Quickshell
      kdePackages.qqc2-desktop-style # Kde's QtQuick controls which uses the applcations QStyle theme
      kdePackages.sonnet # Not sure if this is needed
      pkgs.kdePackages.kirigami.passthru.unwrapped # Need the unwrapped version for kde's qqc2 style (i think)

      # Icon theme
      kdePackages.breeze

      # Qt styles
      darkly
      adwaita-qt6
      kdePackages.oxygen
      libsForQt5.qtstyleplugins
    ];
  };

  hjem.users.eXia = {
    enable = true;
    files = {
      /*
      ".config/quickshell" = {
        #source = ./config;
        source = "/home/eXia/NixOS/modules/system/desktop-environments/leaf/quickshell/config/"; # For development
        clobber = true;
      };
      */
      ".config/quickshell-widgets" = {
        source = inputs.qetris;
        clobber = true;
      };
    };
  };
}
