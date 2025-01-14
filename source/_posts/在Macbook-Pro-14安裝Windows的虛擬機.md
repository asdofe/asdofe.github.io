---
title: 在Macbook Pro 14安裝Windows的虛擬機
date: 2023-02-14 23:48:35
tags:
- apple
- arm64
- windows
---

想在M1版本的Macbook Pro 上跑虛擬的Windows 想不到沒那麼容易...

目前使用的macos是Ventura 13.2

## 準備軟體
1. UTM
* [官網下載](https://mac.getutm.app/)
* 取代Virtualbox 或Parallel 的軟體
* 我Virtualbox 裝不起來
* 使用Windows 頻率極低買Parallel 覺得不划算

2. Windows 11 Arm64 Image
* [官網下載](https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewarm64)
* 不使用.iso 安裝而是使用.vhdx
* .vhdx 要放在空間足夠的地方，image 會隨著Guest OS越來越大
* 本質上就是一個image
* 連結顯示錯誤的話，確認一下是不是沒有登入Microsoft 的帳號，或者是沒有加入Insider Program
* Arm64 base 的Windows
* uupdump上面只有iso檔沒有vhdx檔

## 安裝
基本上GUI照著走都會蠻順利的，而且都中文應該不難裝
1. 建立新的虛擬機
2. 虛擬化 Windows
3. 匯入VHDX 映像檔打勾
4. 瀏覽選擇VHDX 檔
5. 之後設定大概就跟Ｖirtualbox 類似，配ram 配cpu 大小．

* Install Drivers and SPICE tools 是在Guest OS 裏面裝驅動，OS裝好再弄就好

## 可能問題
* 開始安裝流程之後會碰到找不到網路
1. 重新開機進入安裝導引畫面
2. 在選擇安裝語言的地方按下Shfit + F10 跳出command line 視窗
3. 輸入`OOBE\BYPASSNRO`按下enter
4. 重新開機
5. 網路那邊就可以略過了

參考：[networking-does-not-work](https://docs.getutm.app/guides/windows/#networking-does-not-work)