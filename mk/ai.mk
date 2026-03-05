.PHONY: ai

install-ai:
	git clone https://github.com/3axap4eHko/ai.git ~/.local/ai/ || git -C ~/.local/ai pull
	~/.local/ai/install.sh

save-ai:
	cp -r ~/.config/ccstatusline/ home/.config/
