#! /bin/zsh
source .zshrc.d/env.zsh #environment variables like FZF_PATH to be used here

if [[ `uname` == 'Darwin' ]]
then
    # Install Homebrew & Cask
    if [ ! hash git 2>/dev/null ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo "HomeBrew is already installed!"
    fi

    brew tap Homebrew/bundle
    brew bundle --verbose
else
    echo "This script supports only MacOs installation"
fi

if [ ! -d "$FZF_PATH" ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_PATH"
	"$FZF_PATH/install" --all
else 
	echo "FZF already installed"
fi

if [ ! -d "$REMOTECOPY_PATH" ]; then
    git clone https://github.com/justone/remotecopy "$REMOTECOPY_PATH"
    ln -s $REMOTECOPY_PATH/remotecopy ~/bin
    ln -s $REMOTECOPY_PATH/remotecopyserver ~/bin
    if [[ `uname` == 'Darwin' ]]; then 
    "$REMOTECOPY_PATH/remotecopyserver" -x start
    fi
else
  echo "Remote copy already installed. run start command (\"remotecopyserver -x start\" on local, NOT remote) if copy still not working"
fi


mkdir -p $HOME/.vim/undo
