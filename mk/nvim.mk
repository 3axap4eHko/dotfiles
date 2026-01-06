.PHONY: install-nvim upgrade-nvim config-nvim clean-nvim uninstall-nvim save-nvim

install-nvim:
	@if [ -d "$(XDG_CONFIG_HOME)/nvim" ]; then \
		echo "Error: $(XDG_CONFIG_HOME)/nvim exists, please backup or remove it"; \
		exit 1; \
	fi
	curl -fsSLO https://github.com/neovim/neovim/releases/latest/download/$(NVIM_FILE).tar.gz
	tar -xzf $(NVIM_FILE).tar.gz
	rm -rf $(NVIM_FILE).tar.gz $(HOME)/.nvim/
	mv $(NVIM_FILE)/ ~/.nvim/
	@if ! grep -q '# nvim' $(PROFILE); then \
		printf '\n# nvim\nexport NVIM_HOME="$$HOME/.nvim"\nexport PATH="$$NVIM_HOME/bin:$$PATH"\n' >> $(PROFILE); \
	fi
	curl -fsSLO https://github.com/NvChad/starter/archive/refs/heads/main.zip
	unzip main.zip
	rm main.zip
	mv starter-main/ $(XDG_CONFIG_HOME)/nvim
	$(MAKE) config-nvim

upgrade-nvim:
	curl -fsSLO https://github.com/neovim/neovim/releases/latest/download/$(NVIM_FILE).tar.gz
	tar -xzf $(NVIM_FILE).tar.gz
	rm -rf $(NVIM_FILE).tar.gz $(HOME)/.nvim/
	mv $(NVIM_FILE)/ ~/.nvim/

config-nvim: clean-nvim
	cp -r ./home/.config/nvim/ $(XDG_CONFIG_HOME)/nvim/
	$(HOME)/.nvim/bin/nvim

clean-nvim:
	rm -rf ~/.local/state/nvim
	rm -rf ~/.local/share/nvim
	rm -rf ~/.cache/nvim
	rm -rf $(XDG_CONFIG_HOME)/nvim

uninstall-nvim: clean-nvim
	rm -rf ~/.nvim

save-nvim:
	mkdir -p ./home/.config/nvim
	cp -r $(XDG_CONFIG_HOME)/nvim/ ./home/.config/ || true
