---
title: 'tcpdump常用指令'
date: 2020-06-04 18:56:29
tags:
---

抓http封包
```bash
sudo tcpdump -s 0 -v -n -l -i any | egrep -i "POST /|GET /|Host:"
```