{
  lib,
  pkgs,
  config,
  ...
}: {
  options.leaf-shell = {
    enable = lib.options.mkOption {
      type = lib.types.bool;
      default = false;
    };
    user = lib.options.mkOption {
      type = lib.types.str;
      default = "";
    };
  };

  config = lib.mkIf config.leaf-shell.enable {
    imports = [
      ./nixos-config
    ];
  };
}
