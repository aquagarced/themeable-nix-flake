{
  description = "A Plymouth theme displaying a themeable growing and shrinking NixOS Logo";

  outputs = inputs:
  {
    nixosModules.default = ./modules.nix;
  };
}
