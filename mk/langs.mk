.PHONY: install-python install-go install-rust install-zig install-miniconda

install-python: install
	curl -fsSL https://pyenv.run | bash

install-go: install
	sudo rm -rf /usr/local/go
	curl -fsSL https://go.dev/dl/go$(GO_VERSION).$(GO_ARCH).tar.gz | sudo tar -C /usr/local -xzf -
	@if ! grep -q '# go' $(PROFILE); then \
		printf '\n# go\nexport GO_HOME="/usr/local/go"\nexport GO_HOME_LOCAL="$$HOME/go"\nexport PATH="$$GO_HOME/bin:$$GO_HOME_LOCAL/bin:$$PATH"\n' >> $(PROFILE); \
	fi

install-rust: install
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

install-zig:
	rm -rf ~/.zig
	curl -fsSL https://ziglang.org/download/$(ZIG_VERSION)/$(ZIG_FILE).tar.xz | tar -C ~/ -xJf -
	mv ~/$(ZIG_FILE) ~/.zig/
	@if ! grep -q '# zig' $(PROFILE); then \
		printf '\n# zig\nexport ZIG_HOME="$$HOME/.zig"\nexport PATH="$$ZIG_HOME:$$PATH"\n' >> $(PROFILE); \
	fi

install-miniconda:
	curl -fsSLO https://repo.anaconda.com/miniconda/$(MINICONDA_FILE)
	bash $(MINICONDA_FILE)
	rm $(MINICONDA_FILE)
