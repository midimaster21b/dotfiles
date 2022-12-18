# Copy config files to the appropriate locations
cp .bashrc ~
cp .gitconfig ~
cp .quotes ~
cp .tmux.conf ~
cp -r .emacs.d ~

# Install the libraries
sudo apt install libsqlite3-dev libreadline-dev zlib1g-dev libssl-dev libbz2-dev libffi-dev liblzma-dev

# Install the tools
sudo apt install tmux git emacs curl

# Install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
