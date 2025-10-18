# X11 Macro

[![Nix](https://img.shields.io/badge/built%20with-Nix-blue.svg)](https://nixos.org/)

A lightweight wrapper around `xmacrorec2` and `xmacroplay`, for recording and playback, built with Nix. Designed for automation, testing, and repetitive task execution in X11 environments.

## Installation

### Using Nix Flakes

```bash
# Run directly without installation
nix run github:dejanr/x11-macro

# Install to profile
nix profile install github:dejanr/x11-macro
```

### Development Environment

```bash
# Enter development shell with all dependencies
nix develop
```

## Quick Start

### Recording a Macro

Record your mouse movements and keyboard inputs:

```bash
x11-macro record my-automation
```

The recording will start immediately. Press `F9` to stop recording (configurable in `xmacro.ini`).

### Playing a Macro

Execute the recorded macro:

```bash
# Play once
x11-macro play my-automation 1

# Play 10 times
x11-macro play my-automation 10
```

## Configuration

### Macro Settings (`xmacro.ini`)

X11 Macro uses an INI configuration file to control recording and playback behavior. See [`xmacro.ini`](./xmacro.ini) for the current configuration.

```ini
[Playback]
speed=1.000000        # Playback speed multiplier (0.1-10.0)
scale=1.000000        # Coordinate scaling factor for different resolutions
EventDuration=10      # Delay between events in milliseconds

[Record]
scale=1.000000        # Recording coordinate scaling
hasQuitKey=1          # Enable quit key during recording (1=enabled, 0=disabled)
QuitKey=74           # F9 key (X11 keycode) - Press to stop recording
hasScreenshotKey=0   # Enable screenshot feature (1=enabled, 0=disabled)
ScreenshotKey=72     # F6 key (X11 keycode) - Press to take screenshot
```

**Key Configuration Tips:**
- **QuitKey=74** (F9) - Press F9 to stop recording
- **Speed adjustment** - Lower values (0.5) slow down playback, higher values (2.0) speed it up
- **Coordinate scaling** - Useful when recording on one resolution and playing on another
- **X11 Keycodes** - Use `xev` command to find keycodes for different keys

**Common X11 Keycodes:**
- F1-F12: 67-78
- Escape: 9
- Space: 65
- Enter: 36
- Ctrl: 37, 105

📖 **References:**
- [xmacro Documentation](http://xmacro.sourceforge.net/)
- [X11 Keycode Reference](https://gitlab.freedesktop.org/xorg/xserver/-/blob/master/include/keynames.h)
- Find any keycode: Run `xev` and press the desired key

## API Reference

### Commands

| Command | Syntax | Description |
|---------|--------|-------------|
| `record` | `x11-macro record <filename>` | Record a new macro to file |
| `play` | `x11-macro play <filename> <iterations>` | Play macro N times |
| `help` | `x11-macro help` | Show usage information |

### Configuration Files

| File | Purpose | Location |
|------|---------|----------|
| [`xmacro.ini`](./xmacro.ini) | Recording & playback settings | Project root |
| `*.macro`    | Recorded macro files | User-defined (e.g., `./macros/`) |

### Exit Codes

- `0` - Success
- `1` - General error
- `2` - Invalid arguments

### File Formats

Macro files use the xmacro binary format. Files are platform-independent but tied to specific screen resolutions and applications.

## Development

### Building from Source

```bash
git clone <repository-url>
cd x11-macro
nix build
```

### Dependencies

- **xmacro** - Core X11 macro functionality
- **bash** - Script execution environment
- **coreutils** - Basic utilities (seq, cat)

### Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes following the existing code style
4. Test with `nix build`
5. Submit a pull request

---

Built with ❤️ using [Nix](https://nixos.org)
