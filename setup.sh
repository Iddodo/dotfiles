#!/usr/bin/env sh

# Install Brew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Babashka
brew install borkdude/brew/babashka

# Let Babashka script handle the rest
cd setup && bb setup
