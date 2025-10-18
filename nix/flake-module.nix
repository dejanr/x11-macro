{ ... }:
{
  perSystem =
    {
      self',
      pkgs,
      ...
    }:
    {
      packages = {
        default = self'.packages.x11-macro;

        x11-macro = pkgs.callPackage ./package.nix { };
      };

      devShells = {
        default = pkgs.mkShell {
          name = "x11-macro-shell";

          buildInputs = with pkgs; [
            xmacro
            xdotool
          ];

          shellHook = ''
            echo "🎯 X11 Macro Shell"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "Available commands:"
            echo "  nix build                   # Build the package"
            echo "  nix run                     # Run x11-macro"
            echo "  nix develop                 # Enter this shell"
            echo ""
          '';
        };
      };

      apps = {
        default = self'.apps.x11-macro;

        x11-macro = {
          type = "app";
          program = "${self'.packages.x11-macro}/bin/x11-macro";
        };
      };

      checks = {
        build = self'.packages.x11-macro;

        format =
          pkgs.runCommand "check-format"
            {
              buildInputs = [ pkgs.nixpkgs-fmt ];
            }
            ''
              mkdir $out
              nixpkgs-fmt --check ${../flake.nix}
              nixpkgs-fmt --check ${./flake-module.nix}
              nixpkgs-fmt --check ${../default.nix}
            '';
      };

      formatter = pkgs.nixpkgs-fmt;
    };
}
