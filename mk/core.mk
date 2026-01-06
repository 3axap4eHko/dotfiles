.PHONY: install pre-install install-configs save backup

install: pre-install
	@echo "Install"
	@echo "Profile $(PROFILE)"

pre-install:
	@echo "Pre Install"

install-configs:
	find home/ -maxdepth 1 -type f -name ".*" -exec cp {} $$HOME \;
	@if ! grep -q '# dotfiles' $(PROFILE); then \
		printf '\n# dotfiles\n. ~/.exports\n. ~/.aliases\n. ~/.functions\n. ~/.prompt\n' >> $(PROFILE); \
	fi

save: save-zed save-tmux save-nvim save-opencode
	cp ~/.exports ./home/ || true
	cp ~/.aliases ./home/ || true
	cp ~/.functions ./home/ || true
	cp ~/.preexec ./home/ || true
	cp ~/.init_bash ./home/ || true
	cp ~/.init_zsh ./home/ || true
	cp ~/.rules ./home/ || true

save-opencode:
	cp -r $(XDG_CONFIG_HOME)/opencode/opencode.json $(XDG_CONFIG_HOME)/opencode/oh-my-opencode.json ./home/.config/opencode/ || true

backup:
ifeq ($(OS),WSL)
	cp -r ~/bin /mnt/wsl/work/backups
	cp -r ~/.ssh /mnt/wsl/work/backups
else
	@echo "backup target is only available on WSL"
endif
