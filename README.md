# Homebrew Tap

Homebrew tap for EasyAlias.

## Install

```sh
brew tap hannesgnann-hub/tap
brew install --cask easyalias
```

Or directly:

```sh
brew install --cask hannesgnann-hub/tap/easyalias
```

## Release Updates

For a new EasyAlias release, update `Casks/easyalias.rb`:

```ruby
version "1.0.1"
sha256 "NEW_SHA256"
```

Then commit and push the change.
