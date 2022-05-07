install: install-linux
	echo 1

install-linux:
	sudo apt-get update -y && sudo apt-get install software-properties-common build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev -y

install-wsl:
	sudo apt-get update -y && sudo apt-get install software-properties-common build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev -y

install-macos:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

install-python: install
	curl https://pyenv.run | bash
	exec $SHELL

install-rust: install
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	exec $SHELL

install-node: install
	curl -fsSL https://fnm.vercel.app/install | bash
	exec $SHELL
