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

          shellHook = # bash
            ''
              echo "X11 Macro Shell"
              echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
              echo "  nix build                   # Build the package"
              echo "  nix run                     # Run x11-macro"
              echo ""
            '';
        };
      };

      apps = {
        default = self'.apps.x11-macro;

        x11-macro = {
          type = "app";
          program = "${self'.packages.x11-macro}/bin/x11-macro";
          meta.description = "A lightweight wrapper around xmacrorec2 and xmacroplay";
        };
      };

      checks = {
        build = self'.packages.x11-macro;

        format =
          pkgs.runCommand "check-format"
            {
              buildInputs = [ pkgs.nixfmt-rfc-style ];
            }
            ''
              mkdir $out
              nixfmt --check ${../flake.nix}
              nixfmt --check ${./flake-module.nix}
              nixfmt --check ${./package.nix}
            '';
      };

      formatter = pkgs.nixfmt-tree;
    };
}
