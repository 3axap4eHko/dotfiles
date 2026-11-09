.PHONY: install-tmux config-tmux clean-tmux uninstall-tmux save-tmux

install-tmux:
	curl -fsSLO https://github.com/tmux/tmux/releases/download/$(TMUX_VERSION)/tmux-$(TMUX_VERSION).tar.gz
	tar -xzf tmux-$(TMUX_VERSION).tar.gz
	(cd tmux-$(TMUX_VERSION) && ./configure && make && sudo make install)
	tmux -V
	rm -rf tmux-*
	git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
	$(MAKE) config-tmux

config-tmux:
	mkdir -p "$(XDG_CONFIG_HOME)/tmux"
	cp ./home/.config/tmux/tmux.conf "$(XDG_CONFIG_HOME)/tmux/tmux.conf"

clean-tmux:
	rm -rf $(XDG_CONFIG_HOME)/tmux

uninstall-tmux: clean-tmux
	rm -rf ~/.tmux

save-tmux:
	mkdir -p ./home/.config/tmux
	cp $(XDG_CONFIG_HOME)/tmux/tmux.conf ./home/.config/tmux/ || true
