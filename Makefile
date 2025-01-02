install: pre-install
	echo "Install"

pre-install:
	echo "Pre Install"

install-linux:
	sudo locale-gen en_US.UTF-8
	sudo apt-get update -y && sudo apt-get install gcc make software-properties-common unzip xz-utils build-essential libevent-dev libncurses-dev zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev curl -LO curl libbz2-dev jq -y
	sudo apt-get remove -y tmux
	cp -r home/.* home/* $$HOME/
	if ! grep -q '# dotfiles' ~/.bashrc; then \
		echo '\n# dotfiles\n. ~/.exports\n. ~/.aliases\n. ~/.functions\n. ~/.prompt\n' >> ~/.bashrc; \
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
	curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	bash Miniconda3-latest-Linux-x86_64.sh

FIRA_VERSION=3.3.0

install-fira:
	rm -rf FiraCode.zip
	curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v$(FIRA_VERSION)/FiraCode.zip
	unzip -o FiraCode.zip -d ~/.fonts
	fc-cache -fv

ZIG_VERSION=0.13.0

install-zig:
	rm -rf zig-linux-x86_64*
	curl -LO https://ziglang.org/download/$(ZIG_VERSION)/zig-linux-x86_64-$(ZIG_VERSION).tar.xz
	unxz zig-linux-x86_64-$(ZIG_VERSION).tar.xz
	tar -xvf zig-linux-x86_64-$(ZIG_VERSION).tar
	rm -rf ~/.zig
	mv zig-linux-x86_64-$(ZIG_VERSION) ~/.zig/
	rm -rf zig-linux-x86_64-$(ZIG_VERSION)*
	if ! grep -q '# zig' ~/.bashrc; then \
		echo '\n# zig\nexport ZIG_HOME=$$HOME/.zig\nexport PATH=$$ZIG_HOME/bin:$$PATH' >> ~/.bashrc; \
	fi

install-fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

uninstall-tmux:
	rm -rf ~/.tmux
	rm -rf $(XDG_CONFIG_HOME)/tmux

TMUX_VERSION=3.5a
install-tmux:
	curl -LO https://github.com/tmux/tmux/releases/download/$(TMUX_VERSION)/tmux-$(TMUX_VERSION).tar.gz
	tar -xzvf tmux-$(TMUX_VERSION).tar.gz
	(cd tmux-$(TMUX_VERSION) && ./configure && make && sudo make install)
	bash -c "tmux -V"
	rm -rf tmux-*
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

install-tmux-config:
	mkdir -p $(XDG_CONFIG_HOME)/tmux
	cp ./home/.config/tmux/tmux.conf $(XDG_CONFIG_HOME)/tmux/tmux.conf

uninstall-nvim:
	rm -rf ~/.nvim
	rm -rf $(XDG_CONFIG_HOME)/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.local/share/nvim

install-nvim:
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	tar -xzvf nvim-linux64.tar.gz
	rm -rf nvim-linux64.tar.gz ~/.nvim/
	mv nvim-linux64/ ~/.nvim/
	if ! grep -q '# nvim' ~/.bashrc; then \
		echo '\n# nvim\nexport NVIM_HOME=$$HOME/.nvim\nexport PATH=$$NVIM_HOME/bin:$$PATH' >> ~/.bashrc; \
	fi

install-nvim-lazyvim: install-nvim
	@if [ -d "$$XDG_CONFIG_HOME/nvim" ]; then \
		echo "Error: $$XDG_CONFIG_HOME/nvim exists, please backup or remove it"; \
		exit 1; \
	fi
	git clone https://github.com/LazyVim/starter ~/.config/nvim --depth 1 && nvim
	rm -rf ~/.config/nvim/.git/

install-nvim-nvchad: install-nvim
	@if [ -d "$$XDG_CONFIG_HOME/nvim" ]; then \
		echo "Error: $$XDG_CONFIG_HOME/nvim exists, please backup or remove it"; \
		exit 1; \
	fi
	git clone https://github.com/NvChad/starter.git $(XDG_CONFIG_HOME)/nvim --depth 1 && nvim
	rm -rf $(XDG_CONFIG_HOME)/nvim/.git/

install-nvim-config:
	mkdir -p ~/.config/nvim/lua/custom/
	cp -r ./home/.config/nvim/lua/custom/* ~/.config/nvim/lua/custom/

save:
	cp ~/.config/tmux/tmux.conf ./home/.config/tmux/
	cp -r ~/.config/nvim/lua/* ./home/.config/nvim/lua/

backup:
	cp -r ~/bin /mnt/wsl/work/backups
	cp -r ~/.ssh /mnt/wsl/work/backups
