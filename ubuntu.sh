# Copy config files to the appropriate locations
cp .bashrc ~
cp .gitconfig ~
cp .quotes ~
cp .tmux.conf ~
cp -r .emacs.d ~

# Install Xilinx Vivado prerequisite libraries
sudo apt -y install libncurses5 libtinfo5 libncurses5-dev libncursesw5-dev

# Install python prerequisite libraries
sudo apt -y install build-essential libsqlite3-dev libreadline-dev zlib1g-dev libssl-dev libbz2-dev libffi-dev liblzma-dev

# Install the tools
sudo apt -y install tmux git emacs curl

# Install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
