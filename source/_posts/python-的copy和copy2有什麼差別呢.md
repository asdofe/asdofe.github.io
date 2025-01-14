---
title: python 的copy和copy2有什麼差別呢
date: 2019-01-17 00:10:55
tags:
- python
- 開發
---

# python 的copy和copy2有什麼差別呢

---

是說python有一些很方便的copy指令，copy和copy2到底有什麼差別呢?

copy2有複製metadata但copy沒有

簡而言之

copy2 = copy + copystat


REF:https://docs.python.org/3/library/shutil.html#shutil.copy