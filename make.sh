#!/bin/bash

set -eE
# stop script on interrupt (esp. for loops)
trap 'exit 130' INT

if [ ! -d ~/.oh-my-zsh  ]; then
  echo "Fetching ZSH"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# make sure default shell is zsh
if [[ $SHELL != $(which zsh) ]]; then                                                                                                                                         [master][ruby-2.6.5]
  chsh -s $(which zsh)
fi

dir=~/dotfiles
olddir=~/dotfiles_old
files=$(git ls-files *[^.sh,^.terminal])

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
  packages="z redis postgresql bat jq python3 cmake macvim mono go nodejs zsh-syntax-highlighting yarn docker terraform rg tmux nvim"
  for package in $packages; do
    # Check if already installed
    if brew list $package > /dev/null; then
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

if which rvm > /dev/null; then
  echo "rvm already installed"
else
  echo "installing rvm"
  curl -sSL https://get.rvm.io | bash
fi

if [ ! -d ~/.vim/plugged ]; then
  echo "Fetching Plug..."
  # for vim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # for nvim
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

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

echo "Removing old dotfiles"
rm -r $olddir

echo "Done!"
