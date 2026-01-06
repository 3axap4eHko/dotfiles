.PHONY: install-zed-server config-zed save-zed

install-zed-server:
	mkdir -p ~/.zed_server
	curl -fsSL "$$(curl -sL https://api.github.com/repos/zed-industries/zed/releases/latest | jq -r '.assets[] | select(.name == "$(ZED_ASSET)") | .browser_download_url')" | gunzip > ~/.zed_server/zed-remote-server-dev-build
	chmod +x ~/.zed_server/zed-remote-server-dev-build
	@echo "Zed server installed at ~/.zed_server/zed-remote-server-dev-build"

save-zed:
	mkdir -p ./home/.config/zed
ifeq ($(OS),WSL)
	@ZED_DIR="/mnt/c/Users/$$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')/AppData/Roaming/Zed"; \
	grep -v '^\s*//' "$$ZED_DIR/settings.json" | jq '.wsl_connections[].projects = []' > ./home/.config/zed/settings.json; \
	cp "$$ZED_DIR/keymap.json" ./home/.config/zed/
else
	grep -v '^\s*//' $(XDG_CONFIG_HOME)/zed/settings.json | jq '.wsl_connections[].projects = []' > ./home/.config/zed/settings.json 2>/dev/null || true
	cp $(XDG_CONFIG_HOME)/zed/keymap.json ./home/.config/zed/ 2>/dev/null || true
endif

config-zed:
ifeq ($(OS),WSL)
	cp ./home/.config/zed/{settings.json,keymap.json} "/mnt/c/Users/$$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')/AppData/Roaming/Zed/"
else
	mkdir -p $(XDG_CONFIG_HOME)/zed
	cp ./home/.config/zed/{settings.json,keymap.json} $(XDG_CONFIG_HOME)/zed/
endif
