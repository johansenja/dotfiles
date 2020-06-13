ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one:
#   https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="gallois"

# Useful plugins for Rails development with Sublime Text
plugins=(gitfast git last-working-dir common-aliases sublime zsh-syntax-highlighting history-substring-search)

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

# pkg confg / openssl for crystal
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opt/openssl/lib/pkgconfig
export PATH="$PATH:/usr/local/opt/gettext/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Use z to jump to directories
source "$(brew --prefix)/etc/profile.d/z.sh"

# fix RVM
source $HOME/.rvm/scripts/rvm

alias serve_https="ruby -r webrick -r webrick/https -r openssl -e 's=WEBrick::HTTPServer.new(Port: 8080, SSLEnable: true, SSLCertificate: OpenSSL::X509::Certificate.new(File.read(\"./cert.pem\")), SSLPrivateKey: OpenSSL::PKey::RSA.new(File.read(\"./key.pem\")), DocumentRoot: File.expand_path(\".\")); trap(\"INT\"){s.shutdown}; s.start'"

# calculator function
c() { printf "%s\n" "$*" | bc }
