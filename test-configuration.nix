{...}: {
  imports = [
    ./default.nix
  ];
  leaf-shell = {
    enable = true;
    user = "eXia";
  };
}
