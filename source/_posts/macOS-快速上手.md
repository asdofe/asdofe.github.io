---
title: macOS 快速上手
date: 2022-06-22 22:04:46
tags:
- dev
- macos
- script
---

# 第三方軟體和設定與快速鍵
* 有一些Windows設計比較好的
* 有一些是順手的設定

## 裝Homebrew
* [參考](https://brew.sh/index_zh-tw)
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

```

## Homebrew CLI
```shell
brew install bat
brew install diff-so-fancy
brew install fzf
brew install ripgrep
brew install thefuck
brew install fd
brew install navi
brew install tig
```

## Homebrew GUI
```shell
brew install --cask alfred
brew install --cask alt-tab
brew install --cask appcleaner
brew install --cask cheatsheet
brew install --cask iterm2
brew install --cask spectable
brew install --cask stats
brew install --cask spotify
brew install --cask microsoft-teams
brew install --cask microsoft-edge
brew install --cask calibre
brew install --cask bingpaper
brew install --cask visual-studio-code
brew install --cask macfuse
brew install --cask vlc
brew install --cask mcbopomofo
brew install --cask aldente
```

## 開發者工具
* [nvm 連結](https://github.com/nvm-sh/nvm)
    * 聽說homebrew裝有坑，建議使用nvm官方安裝法
```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install node
nvm use node
```

* [z - jump around](https://github.com/rupa/z)
```shell
cd ${ZDOTDIR:-$HOME}
git clone git@github.com:rupa/z.git
echo '. z/z.sh' >> ${ZDOTDIR:-$HOME}/.zshrc
```

* [oh my zsh](https://ohmyz.sh/#install)
```shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

* [z-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)

```shell
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/
```

* [z-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)
```shell
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
* [powerlevel10k](https://github.com/romkatv/powerlevel10k#oh-my-zsh)
```shell
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
* 改.zshrc
* 因為plugins需要改~/.zshrc｀
    * z-syntax-highlighting
    * z-autosuggestions
    * powerlevel10k
    * 有一行`plugins=`括號內加入`zsh-syntax-highlighting zsh-autosuggestions`
    * 有一行`ZSH_THEME=`等號右邊改成`"powerlevel10k/powerlevel10k"`

* [power line fonts](https://github.com/powerline/fonts#quick-installation)
```shell
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
```

* diff-so-fancy
    * 已經用Homebrew裝好了
    * 需要設定git global config

```shell
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"
```

* 傳輸速度有夠慢不推 <del>[macFUSE & sshFS](https://github.com/telepresenceio/telepresence/issues/1654#issuecomment-873538291)</del>
    * 會需要關機，再長按開機鍵，跳出安全選單，降低安全層級
    * 進到作業系統內後，mount到一半會需要再授權macFUSE的開發者
    * mount point放在家目錄不用root權限

```shell
# 掛載指令
sshfs -o allow_other,default_permissions <remote site>:<remote directory path> <local directory path>
```

## 快速鍵
* 全選 還原 剪下 複製 貼上：Command + a z x c v 
* 截圖然後存進剪貼簿：Shift + Command + 3或4
* 螢幕錄影：Shift + Command + 5
* 切換輸入法：快速按一下 `Caps Lock` 或 Control + 空白鍵
* 預設英文大寫：長按`Caps Lock`
* 游標跳字：Option + 左或右
* 游標選字：Option + Shift + 左或右
* HOME鍵：Command + 左
* END鍵：Command + 右
* 頁首：Command + 上
* 頁底：Command + 下
* 所有APP縮圖預覽：Control + 上
* 目前APP所有視窗預覽：Control + 下
* 目前APP所有視窗循序切換：Command + `
* Spotlight：Command + 空白鍵
* 大部分的分頁切換：Control + Tab
* 關閉程式：Command + q
* 關閉視窗：Ｃommand + shift + w
* 關閉分頁：Ｃommand + w
* APP切換(很爛)：Command + Tab
* APP切換(第三方AltTab提供)：Option + Tab
* APP填滿畫面(第三方AltTab提供)：Command + Option + f
* APP畫面縮小並做上下左右對齊(第三方Spectable)：Command + Option + 上下左右
* 鎖定畫面：Command + Control + q
* 縮小畫面：Command + h
* 隱藏/顯示Dock：Command + Option + d
* 顯示Dock：滑鼠游標移到左下角
* 強制關閉程式：Command + Option + esc
* 快速鍵查詢：Command 長按

* CLI 內的指令請用Control代替Windows 常用的Ctrl

## macOS預設設定調整
1. 系統偏好設定 > 觸碰式軌跡板
    * (分頁：點按) > 點一下來選按 打勾
    * (分頁：捲動與縮放) > 捲動方向：自然 取消打勾
2. 系統偏好設定 > 鍵盤 > (分頁：鍵盤) > 快速鍵
    * 將螢幕圖片儲存為檔案 和 拷貝螢幕圖片至剪貼板 的快速鍵 對調
    * 將所選區域的圖片儲存為檔案 和 拷貝所選區域的圖片至剪貼板 對調
3. 系統偏好設定 > 滑鼠
    * 捲動方向：自然 取消打勾
    * 捲度速度：拉滿
4. 系統偏好設定 > 共享
    * 電腦名稱：改個短一點的英文
5. 系統偏好設定 > 一般
    * 外觀：深色
    * 預設網頁瀏覽器：Microsoft Edge
