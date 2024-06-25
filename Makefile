install: install2
	echo 1

install2:
	echo 2

install-linux:
	sudo apt-get update -y && sudo apt-get install gcc make software-properties-common unzip build-essential libevent-dev libncurses-dev zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev jq -y
	sudo apt-get remove -y tmux
	cp -r home/.* ~/
	cp -r home/* ~/

install-wsl: install-linux
	echo 'WSL'

install-macos:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

install-python: install
	curl https://pyenv.run | bash
	source ~/.bashrc

install-rust: install
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	source ~/.bashrc

install-node: install
	curl -fsSL https://fnm.vercel.app/install | bash
	source ~/.bashrc

install-miniconda:
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	bash Miniconda3-latest-Linux-x86_64.sh

install-tmux:
	wget https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz
	tar -xzvf tmux-3.3a.tar.gz
	(cd tmux-3.3a && ./configure && make && sudo make install)
	bash -c "tmux -V"
	rm -rf tmux-3.3a*
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	mkdir -p ~/.config/tmux
	cp ./home/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf

install-nvim:
	wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	mkdir -p ~/.local/etc/
	tar -xzvf nvim-linux64.tar.gz -C ~/.local/etc/
	rm nvim-linux64.tar.gz
	sudo ln -s ~/.local/etc/nvim-linux64/bin/nvim /usr/local/bin/nvim
	git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
	cp -r ./home/.config/nvim/lua/custom/* ~/.config/nvim/lua/custom/

backup:
	cp ~/.config/tmux/tmux.conf ./home/.config/tmux/
	cp -r ~/.config/nvim/lua/custom/* ./home/.config/nvim/lua/custom/
