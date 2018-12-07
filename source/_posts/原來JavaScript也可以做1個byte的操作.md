---
title: 原來JavaScript也可以做1個byte的操作
date: 2018-11-28 01:07:40
tags: 
- JavaScript
- Node
- DataView
- Typed Array
---

最近有一些需要用利用強大的pc做簡單的binary decoder的需求。
這件事情直覺想起來真的是痛苦無比啊，認真說我還真不知道把float要怎麼做bitwise運算。
不過既然打了這篇﹐就是有簡單的做法可以分享的意思啦。

其實跟c操作起來感受差別不大，在c習慣把東西裝在char*裡面，然後視情況需要在用各種不同的型態轉換把值取出來這樣。
JS也大概是如此。

基本上會用到的東西大概就3個，ArrayBuffer、DataView和Typed Array。
1. ArrayBuffer就是實際的儲存空間，read-only的一個物件，長度是byteLength，你只能初始化它的大小，值要用另外兩個東西get/set
2. DataView，一個可以任意存取ArrayBuffer的介面型物件，一次set/get 1個uint8/int8/uint16/int16/uint32/int32/float32/float64。
3. Typed Array，跟DataView類似，但他就是Array style的存取方式。我個人比較喜歡用Typed Array用起來跟unsigned char有87%像。

以下使用

* Microsoft Windows [Version 10.0.17134.407]
* gcc (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0
* node v8.11.1

多說無益直接示範如何把一坨binary decode
以下為產生測資的c code，gcc 直接編譯執行即可產生flash.txt
```c
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

//pragma是為了4byte 對齊, 因為我decoder寫死的，雖然我pc是64bit的但我還活在32bit的世界拜託不要叫醒我
#pragma pack(4)
struct Msg
{
    char ts[4];//4byte
    char id[7];//7byte
    char ip[4];//4byte
    char more[12];//12byte
};
int main()
{
    struct Msg obj;
    time_t ts = time(NULL);
    memmove(obj.ts, &ts, sizeof(obj.ts));
    memmove(obj.id, "abcdefg", sizeof(obj.id));

    obj.ip[0] = 0xFF&192;
    obj.ip[1] = 0xFF&168;
    obj.ip[2] = 0xFF&1; 
    obj.ip[3] = 0xFF&100;
    
    int *p_more = (int*)obj.more;
    p_more[0] = 20;
    p_more[1] = 21;
    p_more[2] = 22;

    FILE* fp = fopen("flash.txt", "wb");//該死的windows會幫你的換行加料，強迫他寫binary比較沒事
    fwrite(&obj, sizeof(struct Msg), 1, fp);
    fclose(fp);
    printf("sizeof(msg)=%u,", sizeof(struct Msg));
    printf("{ts: %u, id: %.*s, ip: %u.%u.%u.%u, more: [%d,%d,%d]}", 
    *(unsigned int*)obj.ts, 7, 
    obj.id, 
    0xFF&obj.ip[0], 0xFF&obj.ip[1], 0xFF&obj.ip[2], 0xFF&obj.ip[3], 
    p_more[0], p_more[1], p_more[2]);
}
```
以下為JavaScript寫的decoder，可以直接吃上面code生出來的測資。
把讀檔的部分拿掉應該是可以直上瀏覽器
```JavaScript
const fs = require('fs');
fs.readFile('flash.txt', (err, data) => {
    if(err)
    {
        console.log(err);
        return;
    }
    var u8_arr = Uint8Array.from(data);
    var dv = new DataView(u8_arr.buffer);
    var decode_result = {};
    var islittleEndian = 1;
    //4byte 時間轉字串
    decode_result.ftime = new Date(dv.getUint32(0, islittleEndian) * 1000).toLocaleString();
    //ascii code 轉換
    decode_result.id_str = Array.from(u8_arr.slice(4, 11)).map(val=>String.fromCharCode(val)).join('');
    //4byte ip轉換
    decode_result.ip_list = Array.from(u8_arr.slice(11, 15)).join('.');
    //3個4byte 整數轉換
    decode_result.var_list = Array.from(new Uint32Array(u8_arr.slice(15, 27).buffer));
    console.log(decode_result);
});
```

不得不說用JavaScript處理binary真的舒服的。

參考資料：
https://developer.mozilla.org/zh-TW/docs/Web/JavaScript/Reference/Global_Objects/DataView
https://developer.mozilla.org/zh-TW/docs/Web/JavaScript/Typed_arrays
