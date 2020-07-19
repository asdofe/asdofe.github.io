---
title: vdi檔太肥
date: 2020-06-05 13:06:51
tags:
    - virtualbox
    - vdi
    - dd
    - treesize
---

C槽快爆了，想說用treesize掃一下看是什麼東西在作怪，結果一看居然是常用的虛擬機的vdi檔占了248 G，
明明用df -h看機器內才佔了22G而已啊，所以決定找方法清一下空間。

Guest OS版本是 Ubuntu 19.04
執行
```bash
sudo dd if=/dev/zero of=/free bs=1M
sudo rm -f /free
```
Host OS是 Windows 10 x64版本的
接著執行，記得把vdi的名稱改成要瘦身的vdi的名稱

```dos
‪C:\"Program Files"\Oracle\VirtualBox\VBoxManage.exe modifyhd ubuntu.vdi --compact
```

打完收工




