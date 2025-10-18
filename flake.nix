{
  description = "X11 Macro - A lightweight macro recording and playback utility";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./nix/flake-module.nix
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
}
