# Homebrew Tap

Homebrew formulae for [Seex](https://github.com/reformovo/seex).

## Installation

Install the Seex desktop viewer directly:

```sh
brew install reformovo/tap/seex-app
```

Alternatively, add the tap before installing:

```sh
brew tap reformovo/tap
brew install seex-app
```

Launch the viewer with an optional project path:

```sh
seex-app [PROJECT_PATH]
```

The current formula supports macOS on Apple Silicon.

## Formulae

| Project | Formula | Description |
| --- | --- | --- |
| [Seex](https://github.com/reformovo/seex) | [`seex-app`](Formula/seex-app.rb) | Native desktop curve viewer for Seex |

## Uninstallation

```sh
brew uninstall seex-app
brew untap reformovo/tap
```

For Homebrew documentation, run `brew help` or visit
[docs.brew.sh](https://docs.brew.sh/).
