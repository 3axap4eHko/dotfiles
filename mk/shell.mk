.PHONY: install-zsh config-zsh install-blesh clean-blesh uninstall-blesh

install-zsh:
	curl -fsSL https://ohmyposh.dev/install.sh | bash -s

config-zsh:
	cp -r ./home/.config/ohmyposh/ $(XDG_CONFIG_HOME)/ohmyposh/

install-blesh:
	git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git ~/.local/share/blesh
	make -C ~/.local/share/blesh install PREFIX=~/.local
	@if ! grep -q '# blesh' $(PROFILE); then \
		printf '\n# blesh\n[[ $$- == *i* ]] && . ~/.local/share/blesh/ble.sh --noattach\n' >> $(PROFILE); \
	fi

clean-blesh:
	rm -rf ~/.local/share/blesh
	rm -rf ~/.local/share/blesh-contrib

uninstall-blesh: clean-blesh
ifeq ($(OS),MACOS)
	sed -i '' '/# blesh/,+1d' $(PROFILE)
else
	sed -i '/# blesh/,+1d' $(PROFILE)
endif
