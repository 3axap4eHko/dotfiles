XDG_CONFIG_HOME ?= $(HOME)/.config

OS := $(shell \
  if grep -qi microsoft /proc/version 2>/dev/null; then \
    echo WSL; \
  elif [ "$$(uname)" = "Linux" ]; then \
    echo LINUX; \
  elif [ "$$(uname)" = "Darwin" ]; then \
    echo MACOS; \
  else \
    echo UNKNOWN; \
  fi)

ARCH := $(shell uname -m)

USER_SHELL := $(shell \
  if command -v getent >/dev/null 2>&1; then \
    getent passwd $(USER) | cut -d: -f7; \
  else \
    dscl . -read /Users/$(USER) UserShell 2>/dev/null | awk '{print $$2}'; \
  fi)
SHELL_NAME := $(shell basename $(USER_SHELL))

ifeq ($(SHELL_NAME),zsh)
  PROFILE := $(HOME)/.zshrc
else ifeq ($(OS),MACOS)
  PROFILE := $(HOME)/.bash_profile
else
  PROFILE := $(HOME)/.bashrc
endif

ifeq ($(OS),MACOS)
  FONT_DIR := $(HOME)/Library/Fonts
else
  FONT_DIR := $(HOME)/.fonts
endif

FONT_VERSION := 3.3.0

GO_VERSION := $(shell curl -s https://go.dev/VERSION?m=text | head -1 | sed 's/go//')
ifeq ($(OS),MACOS)
  ifeq ($(ARCH),arm64)
    GO_ARCH := darwin-arm64
  else
    GO_ARCH := darwin-amd64
  endif
else
  ifeq ($(ARCH),aarch64)
    GO_ARCH := linux-arm64
  else
    GO_ARCH := linux-amd64
  endif
endif

ZIG_VERSION := $(shell curl -s https://ziglang.org/download/index.json | jq -r 'del(.master) | to_entries | sort_by(.value.date) | reverse | .[0].key')
ifeq ($(OS),MACOS)
  ZIG_OS := macos
  ifeq ($(ARCH),arm64)
    ZIG_ARCH := aarch64
  else
    ZIG_ARCH := x86_64
  endif
else
  ZIG_OS := linux
  ifeq ($(ARCH),aarch64)
    ZIG_ARCH := aarch64
  else
    ZIG_ARCH := x86_64
  endif
endif
ZIG_FILE := zig-$(ZIG_ARCH)-$(ZIG_OS)-$(ZIG_VERSION)

TMUX_VERSION := $(shell curl -s https://api.github.com/repos/tmux/tmux/releases/latest | jq -r '.tag_name')

NVIM_VERSION := $(shell curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.tag_name')
ifeq ($(OS),MACOS)
  ifeq ($(ARCH),arm64)
    NVIM_ARCH := macos-arm64
  else
    NVIM_ARCH := macos-x86_64
  endif
else
  ifeq ($(ARCH),aarch64)
    NVIM_ARCH := linux-arm64
  else
    NVIM_ARCH := linux-x86_64
  endif
endif
NVIM_FILE := nvim-$(NVIM_ARCH)

WIN32YANK_VERSION := $(shell curl -s https://api.github.com/repos/equalsraf/win32yank/releases/latest | jq -r '.tag_name')

ifeq ($(OS),MACOS)
  ifeq ($(ARCH),arm64)
    MINICONDA_FILE := Miniconda3-latest-MacOSX-arm64.sh
  else
    MINICONDA_FILE := Miniconda3-latest-MacOSX-x86_64.sh
  endif
else
  ifeq ($(ARCH),aarch64)
    MINICONDA_FILE := Miniconda3-latest-Linux-aarch64.sh
  else
    MINICONDA_FILE := Miniconda3-latest-Linux-x86_64.sh
  endif
endif

ifeq ($(ARCH),aarch64)
  ZED_ASSET := zed-remote-server-linux-aarch64.gz
else
  ZED_ASSET := zed-remote-server-linux-x86_64.gz
endif
