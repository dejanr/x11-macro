{ pkgs }:

pkgs.writeShellApplication {
  name = "x11-macro";
  runtimeInputs = [ pkgs.xmacro ];
  text = ''
    option=''${1:-help}

    record() {
      if [[ -z "$1" ]]; then
        echo "Error: record command requires a filename."
        echo ""
        echo "Usage: x11-macro record <filename>"
        echo ""
        echo "Examples:"
        echo "  x11-macro record typing.macro"
        exit 2
      fi

      if [[ -f $1 ]]; then
        echo "Error: File '$1' already exists."
        echo ""
        echo "To overwrite, first remove it:"
        echo "  rm '$1'"
        exit 2
      fi

      echo "Recording macro to '$1'..."
      echo "Press Esc to stop recording."
      xmacrorec2 -k 9 > "$1"
      echo "Macro saved to '$1'"
    }

    play() {
      if [[ -z "$1" || -z "$2" ]]; then
        echo "Error: play command requires both a file and repeat count."
        echo ""
        echo "Usage: x11-macro play <file> <number>"
        echo ""
        echo "Examples:"
        echo "  x11-macro play typing.macro 5"
        exit 2
      fi

      if [[ ! -f $1 ]]; then
        echo "Error: Macro file '$1' not found."
        echo ""
        echo "To record a new macro:"
        echo "  x11-macro record $1"
        exit 2
      fi

      re='^[0-9]+$'
      if ! [[ $2 =~ $re ]]; then
         echo "Error: '$2' is not a valid number."
        echo ""
         echo "Usage: x11-macro play <file> <number>"
         exit 2
      fi

      for _ in $(seq 1 "$2"); do 
        cat "$1" | xmacroplay -d 30 :0.0
      done
    }

    help() {
      echo "x11-macro - Record and play X11 macro sequences"
      echo ""
      echo "Usage:"
      echo "  x11-macro <command> [arguments]"
      echo ""
      echo "Commands:"
      echo "  play <file> <number>    Play a macro file N times"
      echo "  record <filename>       Record a new macro to file (press Esc to stop)"
      echo "  help                    Show this help message"
      echo ""
      echo "Examples:"
      echo "  x11-macro record typing.macro"
      echo "  x11-macro play typing.macro 5"
    }

    case $option in
    play        ) play "''${2:-}" "''${3:-}" ;;
    record      ) record "''${2:-}" ;;
    help        ) help ;;
    *           ) help && exit 1 ;;
    esac
  '';
}
