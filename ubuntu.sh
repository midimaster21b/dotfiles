# Copy config files to the appropriate locations
cp .bashrc ~
cp .gitconfig ~
cp .quotes ~
cp .tmux.conf ~
cp -r .emacs.d ~

# Install the tools
sudo apt install tmux git emacs
