#!/bin/sh


DOTFILE_LOC=$HOME/git/dotfiles

# Create all needed directories
mkdir -p $HOME/.config

# Create soft links
ln -s $DOTFILE_LOC/.doom.d $HOME/.doom.d
ln -s $DOTFILE_LOC/.zshrc $HOME/.zshrc
ln -s $DOTFILE_LOC/.tmux.conf $HOME/.tmux.conf
ln -s $DOTFILE_LOC/macOS-configuration/.macos $HOME/.macos

cd $DOTFILE_LOC/.config
for file in *; do
    ln -s $DOTFILE_LOC/.config/$file $HOME/.config/$file
done
