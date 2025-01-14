---
title: cmake 幫忙編譯多個module
date: 2019-01-16 23:50:05
tags:
- c&c++
- 開發
---

# CMake幫忙一次編好一堆Module順便幫忙編好執行檔
---
CMake真的很方便啊不用自己背一堆make還是gcc的狗屎指令

就可以幫忙編出不論是.a還是.so都可以，而且還不用自己手動copy一堆include的path(好啦嚴格來說他也只是幫忙gen Makefile)

這麼牛逼得tool我實在是不明白為何聲勢還是不如makefile

這邊提示一下 ref1的那個範例需要確保out-of-source-build，意思就是說你的cmake程式進入點不能跟你的CMakeLists.txt在同一個地方。這個問題有2個處理辦法，隨邊開一個資料夾(例如說build)，然後進去build裡面，執行
cmake，就像下面。

然後如果你不希望你的module裡面的資料夾被cmake搞得全部都是ㄧ堆編譯過程產生的中間產物的話，那可以考慮使用
ref2的教學，然後針對module裡面的CMakeLists.txt逐一加上output的路徑，這樣會好一點點。

```sh
cmake ..
```

以上感謝Stack over flow的巨巨無絲分享


Ref:
1. [cmake dependent modules build](https://stackoverflow.com/questions/16398937/cmake-and- finding-other-projects-and-their-dependencies)
2. [cmake output](https://stackoverflow.com/questions/6594796/how-do-i-make-cmake-output-into-a-bin-dir)
