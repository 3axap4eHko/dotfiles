OS := $(shell \
  if grep -qi microsoft /proc/version 2>/dev/null; then \
    echo WSL; \
  elif [ "$(shell uname)" = "Linux" ]; then \
    echo LINUX; \
  elif [ "$(shell uname)" = "Darwin" ]; then \
    echo MACOS; \
  else \
    echo UNKNOWN; \
  fi)

ifeq ($(OS),MACOS)
	PROFILE=~/.bash_profile
else
	PROFILE=~/.bashrc
endif

install: pre-install
	echo "Install"

pre-install:
	echo "Pre Install"

install-linux:
	sudo locale-gen en_US.UTF-8
	sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
	sudo apt-get update -y && sudo apt-get install gcc make software-properties-common unzip xz-utils build-essential libevent-dev libncurses-dev zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev curl wget libbz2-dev jq xclip -y
	sudo apt-get remove -y tmux neovim

install-configs:
	find home/ -maxdepth 1 -type f -name ".*" -exec cp {} $$HOME \;
	if ! grep -q '# dotfiles' $(PROFILE); then \
		echo '\n# dotfiles\n. ~/.exports\n. ~/.aliases\n. ~/.functions\n. ~/.prompt\n' >> $(PROFILE); \
	fi

install-wsl: install-linux
	echo 'WSL'

install-macos:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

install-macos-noroot:
	mkdir ~/.homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/.homebrew
	if ! grep -q '# homebrew' $(PROFILE); then \
		echo '\n# homebrew\nexport HOMEBREW_HOME=$$HOME/.homebrew\nexport PATH=$$HOMEBREW_HOME/bin:$$PATH' >> $(PROFILE); \
	fi

install-zsh:
	curl -s https://ohmyposh.dev/install.sh | bash -s

install-python: install
	curl https://pyenv.run | bash

install-go: install
	sudo add-apt-repository ppa:longsleep/golang-backports
	sudo apt update
	sudo apt install golang-go

install-rust: install
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

install-fnm: install
	curl -fsSL https://fnm.vercel.app/install | bash

install-bun: install
	curl -fsSL https://bun.sh/install | bash

install-deno: install
	curl -fsSL https://deno.land/install.sh | sh

install-miniconda:
	curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	bash Miniconda3-latest-Linux-x86_64.sh

FONT_VERSION=3.3.0
install-jb:
	rm -f JetBrainsMono.zip
	curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v$(FONT_VERSION)/JetBrainsMono.zip
	unzip -o JetBrainsMono.zip -d ~/.fonts
	rm JetBrainsMono.zip
	fc-cache -fv

install-fira:
	rm -f FiraCode.zip
	curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v$(FONT_VERSION)/FiraCode.zip
	unzip -o FiraCode.zip -d ~/.fonts
	rm FiraCode.zip
	fc-cache -fv

ZIG_VERSION=0.13.0
ifeq ($(OS),MACOS)
	ZIG_ARCH=macos-aarch64
else
	ZIG_ARCH=linux-x86_64
endif
ZIG_FILE=zig-$(ZIG_ARCH)-$(ZIG_VERSION)
install-zig:
	rm -rf zig-*
	curl -LO https://ziglang.org/download/$(ZIG_VERSION)/$(ZIG_FILE).tar.xz
	tar -xvf $(ZIG_FILE).tar.xz
	rm -rf ~/.zig
	mv $(ZIG_FILE) ~/.zig/
	rm -rf zig-*
	if ! grep -q '# zig' $(PROFILE); then \
		echo '\n# zig\nexport ZIG_HOME=$$HOME/.zig\nexport PATH=$$ZIG_HOME/bin:$$PATH' >> $(PROFILE); \
	fi

install-bat:
	cargo install bat

install-fzf:
	git clone --depth 1 git@github.com:junegunn/fzf.git ~/.fzf
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
	git clone git@github.com:tmux-plugins/tpm.git ~/.tmux/plugins/tpm
	make config-tmux

config-tmux:
	cp -r ./home/.config/tmux/ $(XDG_CONFIG_HOME)

uninstall-nvim:
	rm -rf ~/.nvim
	rm -rf $(XDG_CONFIG_HOME)/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.local/share/nvim
	rm -rf ~/.cache/nvim

NVIM_VERSION=v0.10.3
ifeq ($(OS),MACOS)
	NVIM_ARCH=macos-x86_64
else
	NVIM_ARCH=linux64
endif

NVIM_FILE=nvim-$(NVIM_ARCH)
install-nvim:
	@if [ -d "$$XDG_CONFIG_HOME/nvim" ]; then \
		echo "Error: $$XDG_CONFIG_HOME/nvim exists, please backup or remove it"; \
		exit 1; \
	fi
	curl -LO https://github.com/neovim/neovim/releases/latest/download/$(NVIM_FILE).tar.gz
	tar -xzvf $(NVIM_FILE).tar.gz
	rm -rf $(NVIM_FILE).tar.gz $(HOME)/.nvim/
	mv $(NVIM_FILE)/ ~/.nvim/
	if ! grep -q '# nvim' $(PROFILE); then \
		echo '\n# nvim\nexport NVIM_HOME=$$HOME/.nvim\nexport PATH=$$NVIM_HOME/bin:$$PATH' >> $(PROFILE); \
	fi
	curl -LO https://github.com/NvChad/starter/archive/refs/heads/main.zip
	unzip main.zip
	mv starter-main $(XDG_CONFIG_HOME)/nvim
	make config-nvim

config-nvim:
	rm -rf ~/.local/state/nvim
	rm -rf ~/.local/share/nvim
	rm -rf ~/.cache/nvim
	cp -r ./home/.config/nvim/ $(XDG_CONFIG_HOME)
	$(HOME)/.nvim/bin/nvim

save:
	cp ~/.config/tmux/tmux.conf ./home/.config/tmux/
	cp -r ~/.config/nvim/ ./home/.config/
	cp -r ~/.config/ohmyposh/ ./home/.config/
	cp ~/.init_* ./home/

backup:
	cp -r ~/bin /mnt/wsl/work/backups
	cp -r ~/.ssh /mnt/wsl/work/backups
