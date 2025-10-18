# X11 Macro

[![Nix](https://img.shields.io/badge/built%20with-Nix-blue.svg)](https://nixos.org/)

A lightweight wrapper around `xmacrorec2` and `xmacroplay`, for recording and playback, built with Nix. Designed for automation, testing, and repetitive task execution in X11 environments.

## Installation

### Using Nix Flakes

Run directly without installation:

```bash
nix run github:dejanr/x11-macro
```

Install to profile:

```bash
nix profile install github:dejanr/x11-macro
```

### Development Environment

Enter development shell with all dependencies

```bash
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

## API Reference

### Commands

| Command | Syntax | Description |
|---------|--------|-------------|
| `record` | `x11-macro record <filename>` | Record a new macro to file |
| `play` | `x11-macro play <filename> <iterations>` | Play macro N times |
| `help` | `x11-macro help` | Show usage information |

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

📖 **References &Notes:**
- [xmacro Documentation](http://xmacro.sourceforge.net/)
- [X11 Keycode Reference](https://gitlab.freedesktop.org/xorg/xserver/-/blob/master/include/keynames.h)
- To find a keycode: Run `xev` and press the desired key

---

Built with ❤️ using [Nix](https://nixos.org)
