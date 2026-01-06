XDG_CONFIG_HOME ?= $(HOME)/.config
SHELL := /bin/bash
.SHELLFLAGS := -ec

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
	sudo apt-get update -y && sudo apt-get install gcc make bison byacc software-properties-common unzip xz-utils build-essential libevent-dev libncurses-dev zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev curl wget libbz2-dev jq -y
	sudo apt-get remove -y tmux neovim

install-configs:
	find home/ -maxdepth 1 -type f -name ".*" -exec cp {} $$HOME \;
	if ! grep -q '# dotfiles' $(PROFILE); then \
		printf '\n# dotfiles\n. ~/.exports\n. ~/.aliases\n. ~/.functions\n. ~/.prompt\n' >> $(PROFILE); \
	fi

WIN32YANK_VERSION := $(shell curl -s https://api.github.com/repos/equalsraf/win32yank/releases/latest | jq -r '.tag_name')

install-wsl: install-linux
	mkdir -p ~/.local/bin
	curl -sL https://github.com/equalsraf/win32yank/releases/download/$(WIN32YANK_VERSION)/win32yank-x64.zip -o win32yank.zip
	unzip -p win32yank.zip win32yank.exe > ~/.local/bin/win32yank
	rm win32yank.zip
	chmod +x ~/.local/bin/win32yank

install-macos:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

install-macos-noroot:
	mkdir ~/.homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/.homebrew
	if ! grep -q '# homebrew' $(PROFILE); then \
		printf '\n# homebrew\nexport HOMEBREW_HOME="$$HOME/.homebrew"\nexport PATH="$$HOMEBREW_HOME/bin:$$PATH"' >> $(PROFILE); \
	fi

install-zsh:
	curl -s https://ohmyposh.dev/install.sh | bash -s

config-zsh:
	cp -r ./home/.config/ohmyposh/ $(XDG_CONFIG_HOME)/ohmyposh/

install-python: install
	curl https://pyenv.run | bash

GO_VERSION=$(shell curl -s https://go.dev/VERSION?m=text | head -1 | sed 's/go//')
ifeq ($(OS),MACOS)
	ifeq ($(shell uname -m),arm64)
		GO_ARCH=darwin-arm64
	else
		GO_ARCH=darwin-amd64
	endif
else
	ifeq ($(shell uname -m),aarch64)
		GO_ARCH=linux-arm64
	else
		GO_ARCH=linux-amd64
	endif
endif

install-go: install
	sudo rm -rf /usr/local/go
	curl -L https://go.dev/dl/go$(GO_VERSION).$(GO_ARCH).tar.gz | sudo tar -C /usr/local -xzvf -
	if ! grep -q '# go' $(PROFILE); then \
		printf '\n# go\nexport GO_HOME="/usr/local/go"\nexport GO_HOME_LOCAL="$$HOME/go"\nexport PATH="$$GO_HOME/bin:$$GO_HOME_LOCAL/bin:$$PATH"\n' >> $(PROFILE); \
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

ZIG_VERSION=$(shell curl -s https://ziglang.org/download/index.json | jq -r 'del(.master) | to_entries | sort_by(.value.date) | reverse | .[0].key')
ifeq ($(OS),MACOS)
	ifeq ($(shell uname -m),arm64)
		ZIG_OS=macos
		ZIG_ARCH=aarch64
	else
		ZIG_OS=macos
		ZIG_ARCH=x86_64
	endif
else
	ifeq ($(shell uname -m),aarch64)
		ZIG_OS=linux
		ZIG_ARCH=aarch64
	else
		ZIG_OS=linux
		ZIG_ARCH=x86_64
	endif
endif
ZIG_FILE=zig-$(ZIG_ARCH)-$(ZIG_OS)-$(ZIG_VERSION)

install-zig:
	rm -rf ~/.zig
	echo "https://ziglang.org/download/$(ZIG_VERSION)/$(ZIG_FILE).tar.xz "
	curl -Ls https://ziglang.org/download/$(ZIG_VERSION)/$(ZIG_FILE).tar.xz | tar -C ~/ -xJvf -
	mv ~/$(ZIG_FILE) ~/.zig/
	if ! grep -q '# zig' $(PROFILE); then \
		printf '\n# zig\nexport ZIG_HOME="$$HOME/.zig"\nexport PATH="$$ZIG_HOME/bin:$$PATH"' >> $(PROFILE); \
	fi

install-bat:
	cargo install bat

install-fzf:
	git clone --depth 1 git@github.com:junegunn/fzf.git ~/.fzf
	~/.fzf/install

install-zed-server:
	mkdir -p ~/.zed_server
	curl -L "$$(curl -sL https://api.github.com/repos/zed-industries/zed/releases/latest | jq -r '.assets[] | select(.name == "zed-remote-server-linux-x86_64.gz") | .browser_download_url')" | gunzip > ~/.zed_server/zed-remote-server-dev-build
	chmod +x ~/.zed_server/zed-remote-server-dev-build
	@echo "✓ Zed server installed at ~/.zed_server/zed-remote-server-dev-build"

TMUX_VERSION=$(shell curl -s https://api.github.com/repos/tmux/tmux/releases/latest | jq -r '.tag_name')

install-blesh:
	git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git ~/.local/share/blesh
	make -C ~/.local/share/blesh install PREFIX=~/.local
	if ! grep -q '# blesh' $(PROFILE); then \
		printf '\n# blesh\n[[ $$- == *i* ]] && . ~/.local/share/blesh/ble.sh --noattach\n' >> $(PROFILE); \
	fi

clean-blesh:
	rm -rf ~/.local/share/blesh
	rm -rf ~/.local/share/blesh-contrib

uninstall-blesh: clean-blesh
	sed -i '/# blesh/,+1d' $(PROFILE)

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

NVIM_VERSION=$(shell curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.tag_name')
ifeq ($(OS),MACOS)
	ifeq ($(shell uname -m),arm64)
		NVIM_ARCH=macos-arm64
	else
		NVIM_ARCH=macos-x86_64
	endif
else
	NVIM_ARCH=linux-x86_64
endif

NVIM_FILE=nvim-$(NVIM_ARCH)

upgrade-nvim:
	curl -LO https://github.com/neovim/neovim/releases/latest/download/$(NVIM_FILE).tar.gz
	tar -xzvf $(NVIM_FILE).tar.gz
	rm -rf $(NVIM_FILE).tar.gz $(HOME)/.nvim/
	mv $(NVIM_FILE)/ ~/.nvim/

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
		printf '\n# nvim\nexport NVIM_HOME="$$HOME/.nvim"\nexport PATH="$$NVIM_HOME/bin:$$PATH"' >> $(PROFILE); \
	fi
	curl -LO https://github.com/NvChad/starter/archive/refs/heads/main.zip
	unzip main.zip
	mv starter-main/ $(XDG_CONFIG_HOME)/nvim
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
	cp $(XDG_CONFIG_HOME)/tmux/tmux.conf ./home/.config/tmux/ || true
	cp -r $(XDG_CONFIG_HOME)/nvim/ ./home/.config/ || true
ifeq ($(OS),WSL)
	mkdir -p ./home/.config/zed && cp /mnt/c/Users/$$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')/AppData/Roaming/Zed/{settings.json,keymap.json} ./home/.config/zed/
else
	mkdir -p ./home/.config/zed && cp $(XDG_CONFIG_HOME)/zed/{settings.json,keymap.json} ./home/.config/zed/ 2>/dev/null || true
endif
	cp -r $(XDG_CONFIG_HOME)/opencode/opencode.json $(XDG_CONFIG_HOME)/opencode/oh-my-opencode.json ./home/.config/opencode/ || true
	cp ~/.exports ./home/ 
	cp ~/.aliases ./home/
	cp ~/.functions ./home/
	cp ~/.preexec ./home/ || true
	cp ~/.init_bash ./home/ || true
	cp ~/.init_zsh ./home/ || true
	cp ~/.rules ./home/ || true

backup:
	cp -r ~/bin /mnt/wsl/work/backups
	cp -r ~/.ssh /mnt/wsl/work/backups
