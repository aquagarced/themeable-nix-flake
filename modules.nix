{ pkgs, lib, config, ... }:
let
  toBG = { red, green, blue }:
    "${toString(red   / 255.0)}, " +
    "${toString(green / 255.0)}, " +
    "${toString(blue  / 255.0)}";
  cfg = config;
  themeable-nix-flake = pkgs.callPackage ./default.nix {
    theme = cfg.themeable-nix-flake.theme;
    bgColor = toBG cfg.themeable-nix-flake.bgColor;
  };
in
{
  options.themeable-nix-flake.enable = lib.mkEnableOption "themeable-nix-flake";
  options.themeable-nix-flake.bgColor.red = lib.mkOption {
    type = lib.types.ints.between 0 255;
    default = 255;
  };
  options.themeable-nix-flake.bgColor.green = lib.mkOption {
    type = lib.types.ints.between 0 255;
    default = 255;
  };
  options.themeable-nix-flake.bgColor.blue = lib.mkOption {
    type = lib.types.ints.between 0 255;
    default = 255;
  };
  options.themeable-nix-flake.theme = lib.mkOption {
    type = lib.types.enum [ "themeable_nix_flake" ];
    default = "themeable_nix_flake";
  };
  options.themeable-nix-flake.duration = lib.mkOption {
    type = lib.types.float;
    default = 0.0;
  };
  config.boot.plymouth = lib.mkIf cfg.themeable-nix-flake.enable {
    enable = true;
    themePackages = [ themeable-nix-flake ];
    theme = cfg.themeable-nix-flake.theme;
  };
  config.systemd.services.plymouth-quit = lib.mkIf (cfg.themeable-nix-flake.enable && cfg.themable-nix-flake.duration > 0.0) {
    preStart = "${pkgs.coreutils}/bin/sleep ${toString config.themeable-nix-flake.duration}";
  };
}
