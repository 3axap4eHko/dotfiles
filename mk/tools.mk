.PHONY: install-bat install-fzf

install-bat:
	cargo install bat

install-fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
