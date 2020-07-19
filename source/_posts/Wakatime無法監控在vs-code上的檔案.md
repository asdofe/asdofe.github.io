---
title: Wakatime無法監控在vs code上的檔案
date: 2020-06-05 18:39:36
tags:
    - wakatime
    - vscode
---

原因是因為wakatime無法紀錄用ip掛載的網路磁碟機底下的檔案，所以只需要給他一個domain name就可以了。

簡單的方法是在local底下做hosts的對照表

平台是Windows 10 x64

作法如下

---
假設現在我要把192.168.1.1對應到howareyou這個domain name

在C:\Windows\System32\drivers\etc\hosts加入一筆紀錄

例如

```
192.168.1.1 howareyou
```

試著ping一下看有沒有辦法ping到東西

```
ping howareyou
```

然後用howareyou去建立網路磁碟機的連線，vs code裡面的wakatime就會有反應啦
