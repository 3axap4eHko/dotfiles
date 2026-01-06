.PHONY: install-jb install-fira

install-jb:
	mkdir -p $(FONT_DIR)
	rm -f JetBrainsMono.zip
	curl -fsSLO https://github.com/ryanoasis/nerd-fonts/releases/download/v$(FONT_VERSION)/JetBrainsMono.zip
	unzip -o JetBrainsMono.zip -d $(FONT_DIR)
	rm JetBrainsMono.zip
ifneq ($(OS),MACOS)
	fc-cache -fv
endif

install-fira:
	mkdir -p $(FONT_DIR)
	rm -f FiraCode.zip
	curl -fsSLO https://github.com/ryanoasis/nerd-fonts/releases/download/v$(FONT_VERSION)/FiraCode.zip
	unzip -o FiraCode.zip -d $(FONT_DIR)
	rm FiraCode.zip
ifneq ($(OS),MACOS)
	fc-cache -fv
endif
