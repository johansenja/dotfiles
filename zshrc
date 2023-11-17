ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one:
#   https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="gnzh"

# Useful plugins for Rails development with Sublime Text
plugins=(gitfast git last-working-dir common-aliases sublime history-substring-search)

export BAT_THEME="gruvbox-light"

# Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load rbenv if installed
export PATH="${HOME}/.rbenv/bin:${PATH}"
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export VISUAL=vim
export EDITOR=$VISUAL
export BUNDLER_EDITOR=$EDITOR

export VIMINIT="source ~/.vimrc"

export AWS_REGION=eu-west-1

# pkg confg / openssl for crystal
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opt/openssl/lib/pkgconfig
export PATH="$PATH:/usr/local/opt/gettext/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Use z to jump to directories
source "$(brew --prefix)/etc/profile.d/z.sh"

# fix RVM
source $HOME/.rvm/scripts/rvm

# syntax highlighting
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# calculator function
c() { printf "%s\n" "$*" | bc }

# lat - cat if it's a file, or ls if its a directory
lat () {
	if [ -d $1 ]
	then
		ls -G $1
	elif [ -f $1 ]
  then
    cat $1
  else
    echo "Usage: lat [path], performs cat if path is a file, and ls if a directory"
	fi
}
