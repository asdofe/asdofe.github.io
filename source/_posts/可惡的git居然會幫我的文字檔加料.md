---
title: 可惡的git居然會幫我的文字檔加料
date: 2019-01-16 23:46:17
tags:
- git
- development
---
#這篇是要說關於Git checkout style的問題

![](/assets/擷取.PNG)

相信大家都有看過這個東西。但是可能沒被陰過所以不知道這個東西的厲害。

Windows的換行是\r\n 俗稱CRLF ASCII是0x0D0A
Unix的換行是\n 俗稱LF 0x0A

左邊Git按裝的時候都會跳出這個，但是通常都會按Next&gt;根本不關他寫了啥
沒關係
大部分的時候也不會有事情

我也不確定到底什麼時候會有事情

但是最近常跟shell打交道感觸很深所以專程來研究了一下

1. 第一個是Checkout時會幫你把LF轉成CRLF，但commit會幫你把CRLF轉成LF

2. 第二個是Checkout不轉換，commit會把CRLF轉成LF

3. 第三個就是Checkout或Commit都不轉換

=============

比較常會出問題的地方就是shell script

因為bash沒辦法吃有\r的script

所以如果假設用cygwin 執行用Windows Style Checkout下來的shell script你知道會發生什麼事情了吧

解救辦法：可以用dos2unix把那那一堆東西一次轉好

例如：dos2unix config/\*.sh <-後面這一個參數是路徑啊







