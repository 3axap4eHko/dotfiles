install: pre-install
	echo "Install"

pre-install:
	echo "Pre Install"

install-linux:
	sudo apt-get update -y && sudo apt-get install gcc make software-properties-common unzip xz-utils build-essential libevent-dev libncurses-dev zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget curl libbz2-dev jq -y
	sudo apt-get remove -y tmux
	cp -r home/.* ~/
	cp -r home/* ~/
	if ! grep -q '#dotfiles' ~/.bashrc; then \
		echo '\n#dotfiles\n. ~/.exports\n. ~/.aliases\n. ~/.functions\n. ~/.prompt\n' >> ~/.bashrc; \
	fi

install-wsl: install-linux
	echo 'WSL'

install-macos:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

install-python: install
	curl https://pyenv.run | bash
	source ~/.bashrc

install-go: install
	sudo add-apt-repository ppa:longsleep/golang-backports
	sudo apt update
	sudo apt install golang-go
	source ~/.bashrc

install-rust: install
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	source ~/.bashrc

install-fnm: install
	curl -fsSL https://fnm.vercel.app/install | bash
	source ~/.bashrc

install-bun: install
	curl -fsSL https://bun.sh/install | bash
	source ~/.bashrc

install-deno: install
	curl -fsSL https://deno.land/install.sh | sh
	source ~/.bashrc

install-miniconda:
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	bash Miniconda3-latest-Linux-x86_64.sh

ZIG_VERSION=0.13.0

install-zig:
	rm -rf zig-linux-x86_64*
	wget https://ziglang.org/download/$(ZIG_VERSION)/zig-linux-x86_64-$(ZIG_VERSION).tar.xz
	unxz zig-linux-x86_64-$(ZIG_VERSION).tar.xz
	tar -xvf zig-linux-x86_64-$(ZIG_VERSION).tar
	rm -rf ~/.zig
	mv zig-linux-x86_64-$(ZIG_VERSION) ~/.zig/
	rm -rf zig-linux-x86_64-$(ZIG_VERSION)*
	if ! grep -q '#zig' ~/.bashrc; then \
		echo '\n#zig\nexport ZIG_HOME=$$HOME/.zig\nexport PATH=$$ZIG_HOME/bin:$$PATH' >> ~/.bashrc; \
	fi
	source ~/.bashrc

TMUX_VERSION=3.5a
install-tmux:
	wget https://github.com/tmux/tmux/releases/download/$(TMUX_VERSION)/tmux-$(TMUX_VERSION).tar.gz
	tar -xzvf tmux-$(TMUX_VERSION).tar.gz
	(cd tmux-$(TMUX_VERSION) && ./configure && make && sudo make install)
	bash -c "tmux -V"
	rm -rf tmux-*
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

save:
	cp ~/.config/tmux/tmux.conf ./home/.config/tmux/
	cp -r ~/.config/nvim/lua/custom/* ./home/.config/nvim/lua/custom/

backup:
	cp -r ~/bin /mnt/wsl/work/backups
	cp -r ~/.ssh /mnt/wsl/work/backups
