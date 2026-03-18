.PHONY: ai

install-ai:
	git clone https://github.com/3axap4eHko/ai.git ~/.local/ai/ || git -C ~/.local/ai pull
	~/.local/ai/install.sh
	jq -s '.[0] * .[1]' ~/.claude/settings.json home/.claude/statusline.json > /tmp/claude/settings.json && mv /tmp/claude/settings.json ~/.claude/settings.json

save-ai:
	jq '{statusLine}' ~/.claude/settings.json > home/.claude/statusline.json
