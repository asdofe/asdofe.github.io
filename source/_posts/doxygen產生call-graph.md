---
title: doxygen產生call graph
date: 2019-01-16 23:36:27
tags:
- 開發
- c&c++
---
當初trace code有點障礙，想要手動畫call graph，trace了幾行便想放棄，找找看有沒有什麼東西可以幫忙印call graph的。

剛好找到老朋友doxygen，原來他可以幫忙印call graph啊真是太好惹。

---

1. 下載並安裝doxygen本人\(我是抓人家編好的binary下來，windows 安裝好還有doxywizard，把設定過程整個精靈化，非常厲害實在是簡單易用啊\)[ http://www.stack.nl/~dimitri/doxygen/download.html](http://www.stack.nl/~dimitri/doxygen/download.html)
2. 下載並安裝graph viz，這是一個幫忙畫圖的工具，有了這個doxygen才有辦法幫忙畫精美的call graph啊。[http://www.graphviz.org/Download.php](http://www.stack.nl/~dimitri/doxygen/download.html)
3. 安裝好之後必須把graph viz的bin的位置\(預設應該是C:\Program Files \(x86\)\Graphviz2.38\bin\)加入環境變數Path裡面，這樣doxygen就不用在每次設定參數的時候還要手動指定dot這個軟體的path了。
4. 裝好之後跟著精靈走很快就可以做好了。但是有幾個比較關鍵的選項要額外勾一下，Source Code directory下面有一個Scan recursively要勾起來不然不會處理全部的資料夾。在精靈模式底下切到Expert的頁籤底下，如果想要看到完整的function call graph的話記得要把Build-&gt;EXTRACT\_ALL和EXTRACT\_Static打勾。就這樣。設定好之後按下Run doxygen等一下就可以生出精美的html網頁啦。
