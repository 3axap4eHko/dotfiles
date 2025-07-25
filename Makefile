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

USER_SHELL := $(shell getent passwd $(USER) | cut -d: -f7)
SHELL_NAME := $(shell basename $(USER_SHELL))

ifeq ($(SHELL_NAME),zsh)
	PROFILE=~/.zshrc
else ifeq ($(OS),MACOS)
	PROFILE=~/.bash_profile
else
	PROFILE=~/.bashrc
endif

install: pre-install
	echo "Install"
	echo "Profile $(PROFILE)"

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
		printf '\n# dotfiles\n. ~/.exports\n. ~/.aliases\n. ~/.functions\n. ~/.prompt\n' >> $(PROFILE); \
	fi

install-wsl: install-linux
	curl -sL https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip | unzip -p - win32yank.exe | sudo tee /usr/local/bin/win32yank > /dev/null && sudo chmod +x /usr/local/bin/win32yank
	echo 'WSL'

install-macos:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

install-macos-noroot:
	mkdir ~/.homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/.homebrew
	if ! grep -q '# homebrew' $(PROFILE); then \
		printf '\n# homebrew\nexport HOMEBREW_HOME=$$HOME/.homebrew\nexport PATH=$$HOMEBREW_HOME/bin:$$PATH' >> $(PROFILE); \
	fi

install-zsh:
	curl -s https://ohmyposh.dev/install.sh | bash -s

config-zsh:
	cp -r ./home/.config/ohmyposh/ $(XDG_CONFIG_HOME)/ohmyposh/

install-python: install
	curl https://pyenv.run | bash

GO_VERSION=1.24.1
ifeq ($(OS),MACOS)
	GO_ARCH=darwin-arm64
else
	GO_ARCH=linux-amd64
endif

install-go: install
	sudo rm -rf /usr/local/go
	curl -L https://go.dev/dl/go$(GO_VERSION).$(GO_ARCH).tar.gz | sudo tar -C /usr/local -xzvf -
	if ! grep -q '# go' $(PROFILE); then \
		printf '\n# go\nexport GO_HOME=/usr/local/go\nexport PATH=$$GO_HOME/bin:$$PATH' >> $(PROFILE); \
	fi


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

ZIG_VERSION=0.14.0
ifeq ($(OS),MACOS)
	ZIG_ARCH=macos-aarch64
else
	ZIG_ARCH=linux-x86_64
endif
ZIG_FILE=zig-$(ZIG_ARCH)-$(ZIG_VERSION)

install-zig:
	rm -rf ~/.zig
	curl -Ls https://ziglang.org/download/$(ZIG_VERSION)/$(ZIG_FILE).tar.xz | tar -C ~/ -xJvf -
	mv ~/$(ZIG_FILE) ~/.zig/
	if ! grep -q '# zig' $(PROFILE); then \
		printf '\n# zig\nexport ZIG_HOME=$$HOME/.zig\nexport PATH=$$ZIG_HOME/bin:$$PATH' >> $(PROFILE); \
	fi

install-bat:
	cargo install bat

install-fzf:
	git clone --depth 1 git@github.com:junegunn/fzf.git ~/.fzf
	~/.fzf/install

TMUX_VERSION=3.5a

install-tmux:
	curl -LO https://github.com/tmux/tmux/releases/download/$(TMUX_VERSION)/tmux-$(TMUX_VERSION).tar.gz
	tar -xzvf tmux-$(TMUX_VERSION).tar.gz
	(cd tmux-$(TMUX_VERSION) && ./configure && make && sudo make install)
	bash -c "tmux -V"
	rm -rf tmux-*
	git clone git@github.com:tmux-plugins/tpm.git ~/.tmux/plugins/tpm
	make config-tmux

clean-tmux:
	rm -rf $(XDG_CONFIG_HOME)/tmux

uninstall-tmux: clean-tmux
	rm -rf ~/.tmux

config-tmux: clean-tmux
	cp -r ./home/.config/tmux/ $(XDG_CONFIG_HOME)/tmux

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
		printf '\n# nvim\nexport NVIM_HOME=$$HOME/.nvim\nexport PATH=$$NVIM_HOME/bin:$$PATH' >> $(PROFILE); \
	fi
	curl -LO https://github.com/NvChad/starter/archive/refs/heads/main.zip
	unzip main.zip
	mv starter-main $(XDG_CONFIG_HOME)/nvim
	make config-nvim

clean-nvim:
	rm -rf ~/.local/state/nvim
	rm -rf ~/.local/share/nvim
	rm -rf ~/.cache/nvim
	rm -rf $(XDG_CONFIG_HOME)/nvim

config-nvim: clean-nvim
	cp -r ./home/.config/nvim/ $(XDG_CONFIG_HOME)/nvim/
	$(HOME)/.nvim/bin/nvim

uninstall-nvim: clean-nvim
	rm -rf ~/.nvim

save:
	cp $(XDG_CONFIG_HOME)/tmux/tmux.conf ./home/.config/tmux/
	cp -r $(XDG_CONFIG_HOME)/nvim/ ./home/.config/
	cp -r $(XDG_CONFIG_HOME)/zed/ ./home/.config/
	cp -r $(XDG_CONFIG_HOME)/ohmyposh/ ./home/.config/
	cp ~/.exports ./home/
	cp ~/.aliases ./home/
	cp ~/.functions ./home/
	cp ~/.preexec ./home/

backup:
	cp -r ~/bin /mnt/wsl/work/backups
	cp -r ~/.ssh /mnt/wsl/work/backupsaasdte
