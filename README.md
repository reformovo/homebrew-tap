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

Open the native app bundle directly:

```sh
open "$(brew --prefix seex-app)/Seex.app"
```

The current formula supports macOS on Apple Silicon. Release bottles contain
the complete ad-hoc-signed app bundle, including its Finder and Dock icon, and
do not require Rust or other build dependencies at install time.

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

## Publishing bottles

Formula changes are tested and bottled on pull requests. After the checks pass,
run the `brew pr-pull` workflow with the pull request number and optional head
SHA. It uploads the bottle to GitHub Packages and commits the bottle stanza.
