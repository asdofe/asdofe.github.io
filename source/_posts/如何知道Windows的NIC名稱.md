---
title: '如何知道Windows的NIC名稱'
date: 2019-05-05 18:57:40
tags:
- 開發
- windows
- note
---

linux內有線網路的網卡名稱通常都會叫做eth0, eth1，但現在比較潮的命名方式是eth帶mac。

而Windows則是在cmd底下輸入

```sh
getmac /v
```
Network Adapter就是名稱。

如果你在用libpcap家族的產品，你會需要它的。




