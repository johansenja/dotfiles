#!/bin/bash

set -eE
# stop script on interrupt (esp. for loops)
trap 'exit 130' INT

dir=~/dotfiles
olddir=~/dotfiles_old
files=$(git ls-files *[^.sh])

echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

echo "Changing to the $dir directory"
cd $dir
echo "...done"

for file in $files; do
  if [ -f ~/.$file ]; then
    echo "Moving $file from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
  fi
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

if [[ "$OSTYPE" == "darwin"* ]]; then
  # simple check to see if homebrew exists
  if which brew > /dev/null; then
    echo "Homebrew already installed"
  else
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo "...done"
  fi

  echo "installing packages with homebrew"
  # cmake macvim python mono go nodejs needed for YCM (vim)
  packages="z redis postgresql bat jq python3 cmake macvim mono go nodejs"
  for package in $packages; do
    # Check if already installed
    if brew info $package > /dev/null; then
      echo "$package already installed. Skipping"
    else
      echo "Installing $package from homebrew"
      brew install $package
      echo "$package successfully installed"
    fi
  done
# elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
else
  echo "No OS-specific setup implemented"
  exit 0
fi

if [ ! -d ~/.vim/plugged ]; then
  echo "Fetching Plug..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # install plugins
  vim +'PlugInstall --sync' +qa

  if [ -d ~/.vim/plugged/YouCompleteMe ]; then
    # compile YCM (vim)
    cd ~/.vim/plugged/YouCompleteMe/
    python3 install.py --all
  fi
else
  echo "~/.vim/plugged already exists. Not fetching Plugged or installing plugins"
fi

echo "Done!"
