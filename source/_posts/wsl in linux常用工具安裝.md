---
title: wsl in linux 常用工具安裝
date: 2020-06-04 14:42:39
tags:
	- linux
	- develop
	- zsh
	- oh-my-zsh
	- ssh
	- git-cz
	- ag
	- tree
	- tmux
	- wsl
---

# 2020/7/19 
沒ping沒systemctl不說。

反應速度實在是太慢了，而且狂吃記憶體，做一樣的事情大概比virtualbox多吃3 G而且還很慢，wsl 1真的太垃圾，無奈我win10又升不上去沒辦法用wsl 2，在用了一個半月之後退回virtualbox。

# 使用WSL的Ubuntu 18.04 LTS
* 使用一個早上心得：還是很慢，ssh進去CLI用oh-my-zsh的agnoster主題按住enter會有明顯的卡頓，virtual box裝Ubuntu連ssh的至少不會。

## 裝常用工具
```bash
sudo apt-get update && sudo apt-get install -y curl tmux zsh silversearcher-ag git tree python3-pip vim htop openssh-server tig\
&& sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## 設定ssh
```bash
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
```
## 重新產生ssh key

```bash
sudo ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
sudo ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

sudo service ssh --full-restart
```
## 裝git-cz

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \	. "$NVM_DIR/nvm.sh" # This loads nvm' >> "$HOME/.$(ps | grep `echo $$` | awk '{ print $4 }')rc"
nvm install node
nvm use node
npm install -g commitizen && npm install -g cz-conventional-changelog
echo '{ "path": "cz-conventional-changelog" }' > ~/.czrc
```

## 裝yarn
```bash
npm -g install yarn
```

- tmux 必須帶-u，否則特殊字型會破圖

- sudo apt-get install libsnmp-dev
- pip3 install flask requests python3-netsnmp pyDes
- tobe remove bs4, pysnmp


- start \\wsl$\Debian

* 解決fake問題

fakeroot, while creating message channels: Function not implemented
This may be due to a lack of SYSV IPC support.
fakeroot: error while starting the `faked' daemon.
/usr/bin/fakeroot: 1: kill: Usage: kill [-s sigspec | -signum | -sigspec] [pid | job]... or
kill -l [exitstatus]
dpkg-buildpackage: error: fakeroot debian/rules clean subprocess returned exit status 1

```sh
- sudo update-alternatives --set fakeroot /usr/bin/fakeroot-tcp
```

* 解決dh問題 make: dh: Command not found

```sh
sudo apt-get install debheper
```