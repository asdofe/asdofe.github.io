---
title: fseek產生的一些毛
date: 2019-01-17 00:13:00
tags:
- 開發
- c&c++
---

## 用C把檔案倒出來不要用"r" 請愛用"rb"

# 由其是在Windows上面
---

問題來源是我打算用fread把我文字檔裡面的東西全部讀進記憶體裡面，所以就照著以下code這麼做了


以下錯誤示範
```
FILE* fp = foepn(my_file, "r");
fseek(fp, 0, SEEK_END);
int file_len = ftell(fp);
char buf[1000] = {0};
fread(buf, sizeof(char), file_len, fp);
buf[file_len] = '\0';
printf("%s\n", buf);
```
如果有印出一些奇怪的東西應該還算正常

根據我的實驗也不是每一個檔案都會出錯，但是特別容易在換行比較多的檔案上，所以合理懷疑戰犯就是OS幫我加料啦
真的是生77你沒事g婆3小，害我花超多時間debug到底是哪個環節出錯

所以沒事不要用"r"請愛用"rb"(我真的是不知道"r"是設計來幹嘛的)

---
後記：[Coding Std](https://www.securecoding.cert.org/confluence/display/c/FIO19-C.+Do+not+use+fseek%28%29+and+ftell%28%29+to+compute+the+size+of+a+regular+file) 這個文件雖然沒用到但是當做增廣見聞有病治病沒病強身啦。(這年頭工程師真的是知道越多寫code越抖越心虛QQ)

ps:這篇打完才發現跟fseek一點關係也沒有阿，fseek只是non-portable而已並不是這篇文章的戰犯啦不好意思誤會一場，標題下得不好請多包涵QQ。
