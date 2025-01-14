---
title: 用shell的history功能去統計你常用的git指令
date: 2019-01-16 23:51:21
tags:
- git
- note
---

# 用shell script統計git 常用指令

其實就是最近一個小報告啦

需要列一下常用的然後分享給大家

口說無憑，把history抓出來group byㄅ

不過囧的是因為最近搞一堆demo 用的玩具repo所以一堆git remote和git clean，

誰整天在git remote啊(丟筆

不過shell居然可以做到這樣真的是不間單啊XD

還有我的環境是zsh喔

```sh
history | grep '[0-9]\+\*\? \+git'|grep -o 'git [a-z]\+'|sort|uniq -c|sort -n -k 1
```