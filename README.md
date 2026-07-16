# Homebrew Tap

Homebrew tap for EasyAlias.

## Install

```sh
brew tap hannesgnann-hub/tap
brew trust hannesgnann-hub/tap
brew install --cask easyalias
```

Or directly:

```sh
brew trust hannesgnann-hub/tap
brew install --cask hannesgnann-hub/tap/easyalias
```

## Gatekeeper Note

EasyAlias v1.0.0 is not notarized yet. The cask signs the installed app locally
and removes Apple's quarantine attribute after installation so macOS can open it.

If macOS still shows "damaged" or "move to Trash", run:

```sh
sudo codesign --force --deep --sign - /Applications/EasyAlias.app
sudo xattr -dr com.apple.quarantine /Applications/EasyAlias.app
```

## Release Updates

For a new EasyAlias release, update `Casks/easyalias.rb`:

```ruby
version "1.0.1"
sha256 "NEW_SHA256"
```

Then commit and push the change.
