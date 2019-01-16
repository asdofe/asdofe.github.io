---
title: 在linux底下如何存取隨身碟呢
date: 2019-01-17 00:09:49
tags:
- linux
- usb
---
在linux底下如何存取隨身碟呢

是說之前用過在ubuntu server底下把/dev/cdrom掛載在/mnt/cdrom底下，那個比較建單

今天這個掛載usb比較複雜一點點，網路上resource也沒這麼多

我花了一點時間才找到可以用的

每個人都叫妳sudo fdisk -l

碼的就是沒看到usb drive啊

以下示範怎麼在ubuntu 底下做到這件事情

---
### 1. 先知道usb的名稱
試試看下面兩個指令，應該是可以讓你知道，你的usb在/dev底下叫做什麼名子
(硬體在linux底下全部都被當成檔案來存取，OS老師以前上課有沒有說過，有嘛)

```sh
$ lsblk
$ sudo blkid
```
像我的這一顆就叫做/dev/sdb

### 2. 開一個 空的資料夾當掛載點
開一個空資料夾
```sh
$ sudo mkdir /mnt/usb
```

### 3. 把usb掛上去
```sh
$ sudo mount /dev/sdb /mnt/usb
```

### 4. 用完了要移除掛載
```sh
$ sudo umount /mnt/usb
```
資料來源:
https://askubuntu.com/questions/37767/how-to-access-a-usb-flash-drive-from-the-terminal
