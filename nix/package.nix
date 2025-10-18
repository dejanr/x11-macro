{ pkgs }:

pkgs.writeShellApplication {
  name = "x11-macro";
  runtimeInputs = [ pkgs.xmacro ];
  text = ''
    option=''${1:-help}

    record() {
      if [ $# -lt 1 ]; then
        echo 1>&2 "$0: not enough arguments"
        exit 2
      elif [ $# -gt 1 ]; then
        echo 1>&2 "$0: too many arguments"
        exit 2
      fi

      if [[ -f $1 ]]; then
        echo 1>&2 "$0: $1 already exists"
        exit 2
      fi

      xmacrorec2 -k 9 > "$1"
    }

    play() {
      if [ $# -lt 2 ]; then
        echo 1>&2 "$0: not enough arguments"
        exit 2
      elif [ $# -gt 2 ]; then
        echo 1>&2 "$0: too many arguments"
        exit 2
      fi

      if [[ ! -f $1 ]]; then
        echo 1>&2 "$0: does not exist"
        exit 2
      fi

      re='^[0-9]+$'
      if ! [[ $2 =~ $re ]]; then
         echo 1>&2 "$0: second argument is not a number"
         exit 2
      fi

      for _ in $(seq 1 "$2"); do 
        cat "$1" | xmacroplay -d 30 :0.0
      done
    }

    help() {
      echo "usage: x11-macro <command>"
      echo ""
      echo "commands:"
      echo "  play <file> <number>    play a macro file N times"
      echo "  record <filename>       record a new macro to file"
      echo "  help                    show this help message"
      echo ""
      echo "examples:"
      echo "  x11-macro play mine 5           # play mine macro 5 times"
      echo "  x11-macro play macros/bow 1     # play bow macro once"
      echo "  x11-macro record new-macro      # record new macro"
      echo ""
    }

    case $option in
    play        ) play "$2" "$3" ;;
    record      ) record "$2" ;;
    help        ) help ;;
    *           ) help && exit 1 ;;
    esac
  '';
}
