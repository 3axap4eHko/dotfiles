.PHONY: install-linux install-wsl install-macos install-macos-noroot

install-linux:
	sudo locale-gen en_US.UTF-8
	sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
	sudo apt-get update -y && sudo apt-get install gcc make bison byacc software-properties-common unzip xz-utils build-essential libevent-dev libncurses-dev zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev curl wget libbz2-dev jq -y
	sudo apt-get remove -y tmux neovim

install-wsl: install-linux
	mkdir -p ~/.local/bin
	curl -fsSL https://github.com/equalsraf/win32yank/releases/download/$(WIN32YANK_VERSION)/win32yank-x64.zip -o win32yank.zip
	unzip -p win32yank.zip win32yank.exe > ~/.local/bin/win32yank
	rm win32yank.zip
	chmod +x ~/.local/bin/win32yank

install-macos:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

install-macos-noroot:
	mkdir -p ~/.homebrew && curl -fsSL https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/.homebrew
	@if ! grep -q '# homebrew' $(PROFILE); then \
		printf '\n# homebrew\nexport HOMEBREW_HOME="$$HOME/.homebrew"\nexport PATH="$$HOMEBREW_HOME/bin:$$PATH"\n' >> $(PROFILE); \
	fi
