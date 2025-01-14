---
title: 我習慣的vim設定檔
date: 2019-01-17 00:07:04
tags:
- vim
- 開發
- linux
---

## 我真的不愛vim

# 但是我更不愛把檔案丟來丟去

自認為我的設定算華麗且好用所已貼上來(其實也是自己用比較方便XD)
[2017.11.18 update]
[我的設定檔](https://github.com/asdofe/MyConf)
直接丟github這樣比較快

[Putty Color Theme](https://github.com/AlexAkulov/putty-color-themes)
putty原生顏色很醜，改顏色又很麻煩，有人幫忙寫好設定檔直接apply 註冊檔超方便。

---

以下是我的.vimrc檔
記得裝vundle

* 2017.11.12修改

```sh
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
以下是~/.vimrc的內容

```vim
set nocompatible " be iMproved, required
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Lokaltog/vim-powerline'
Plugin 'elzr/vim-json'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
```




\[2017070917:00\] 可惡的Powerline一直毀我tmux畫面，只好把它remove，vim改裝vim-airline

```vim
set t_Co=256
syntax on
set shiftwidth=4
set laststatus=2
set cursorcolumn " highlight current column
set cursorline
hi CursorLine ctermbg=8 ctermfg=15 "8 = dark gray, 15 = white
hi Cursor ctermbg=15 ctermfg=8
```

~/.vimrc更新好之後就可以打下面那一串指令vundle就會自動幫忙把plugin裝好辣

```sh
$ vim +PluginInstall +qall
```


