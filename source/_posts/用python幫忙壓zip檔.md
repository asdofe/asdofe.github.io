---
title: 用python幫忙壓zip檔
date: 2019-01-16 23:48:51
tags:
- python
- develop
---
這裡要介紹Python shutil裡面的指令

python這種包山包海這種搞系統起家的語言真的很優秀，連壓縮檔案都可以幫忙做。

而且還可以直接做高階動作(直接assign一個資料夾的路徑直接整個壓起來)

寫python真的是只有舒適而已。

---

但他這個東西有個缺點，就是沒辦法把最外層的資料夾一起押進去。所以如果收到zip檔的人解壓縮開來可能就會很崩潰(散落一地的零碎檔案)。

所以有一些事情就要自己手動做，但是我就是不想跟ZipFile打交道，所以就是先開一個空白資料夾再把檔案丟進去壓。
這樣就可以把東西包再一個資料夾裡面壓。


```python
import shutil
import os

tmp_root = '.tmp'
src = 'archive'
dst = src + '.zip'
tmp_dst = os.path.join(tmp_root, dst)

shutil.copytree(src, tmp_dst)
shutil.make_archive(dst, 'zip', tmp_root)
shutil.rmtree(tmp_dir)
```
如此一來就可以得到檔名為archive的zip檔辣

