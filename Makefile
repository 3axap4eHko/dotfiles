SHELL := /bin/bash
.SHELLFLAGS := -ec

include mk/config.mk
include mk/platform.mk
include mk/core.mk
include mk/shell.mk
include mk/fonts.mk
include mk/langs.mk
include mk/node.mk
include mk/tools.mk
include mk/tmux.mk
include mk/nvim.mk
include mk/zed.mk
