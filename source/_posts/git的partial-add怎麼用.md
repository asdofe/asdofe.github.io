---
title: git的partial add怎麼用
date: 2019-01-17 00:11:58
tags:
- git
- 開發
---
# Git一次add一行變更
#### 我們在用git add的時候，不只可以add一個資料夾底下所有變更，也可以add一個檔案，最猛的是還可以一次只add一行，一次讓一個變更進去staging啊。最近才會用這個功能覺得實在是太厲害了。
---
partial add是用互動式的方式，問你這一團code要怎麼處理
使用方法如下
```sh
git add -p a.txt
```
輸入之後開啟互動模式
```sh
(Stage this hunk [y,n,q,a,d,/,s,e,?]?)
```
y是這整團code都add
n是這整團code都不add
q是離開add模式
a是以下code全add
**e是把這團code抓出來一行一行手動add**
?是可以查詢這一堆指令代表什麼
---
但是我覺得只有e比較麻煩，可能會遇到跟你想的不一樣的地方
假設我今天有一個檔案叫做a.txt，我想add a.txt的某一個變更
![](https://imgur.com/9xkhynN.jpg)
假設我這次只想要**add -456**那一行
它上面寫
```sh
\# To remove '-'' lines, make them ' lines (context).
\# To remove '+' lines, delete them.
```
我的解釋是
##### 不add '-'那一行的話，把-變成' '(空白鍵)
##### 不add '+'那一行的話，把它們整行刪掉。
你如果隨便亂搞，比如說
1. 只拿掉-，沒有補一個空白回去，維持縮排
2. 只拿掉+，沒有整行刪掉
3. 你做了其他什麼神祕的修改
那你就會看到下面這一行。
```sh
Your edited hunk does not apply. Edit again (saying "no" discards!) [y/n]?
```
表示你的code通通沒有被add進去啊