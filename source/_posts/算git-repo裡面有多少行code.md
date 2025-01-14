---
title: 算git repo裡面有多少行code
date: 2019-01-16 23:42:11
tags:
- git
- 開發
---
輸入

```sh 
git diff --stat `git hash-object -t tree /dev/null`
```

即可知道repo裡面有多少行code

沒什麼用但可以拿來打嘴砲 (e.g.,林老師勒林北這個月提交了8千7百行的code啊不能再多了)

Ref : http://stackoverflow.com/questions/4822471/count-number-of-lines-in-a-git-repository