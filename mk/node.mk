.PHONY: install-fnm install-bun install-deno

install-fnm: install
	curl -fsSL https://fnm.vercel.app/install | bash

install-bun: install
	curl -fsSL https://bun.sh/install | bash

install-deno: install
	curl -fsSL https://deno.land/install.sh | sh
