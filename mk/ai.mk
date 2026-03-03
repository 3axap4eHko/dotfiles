.PHONY: ai

ai:
	git clone https://github.com/3axap4eHko/ai.git ~/.local/ai/ || git -C ~/.local/ai pull
	~/.local/ai/install.sh
