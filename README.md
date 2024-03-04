### Clone this repo
```
git clone https://github.com/TechyAditya/neovim-config.git ~/.config/nvim
```

### Install nvim
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -C ~/apps/ -xzf nvim-linux64.tar.gz
```

### Install Packer
```bash
# packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### Install Nodejs
```
# Nodejs 21
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

# Not confirmed dependency
sudo npm install -g estilo
```
### Install compilers
```
# C++
sudo apt install build-essential gdb

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Go 1.22.0
wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
```
