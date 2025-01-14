---
title: rsync小筆記
date: 2019-01-17 00:08:51
tags:
- linux
- 開發
---

# RSYNC小筆記
##### 不敢說是教學啦因為RSYNC從設定檔開始講起真的是太可怕了
##### 講簡單RSYNC就是ㄧ個可以幫忙同步檔案的軟體，而且本地端遠端都可以，它的強項是可以幫忙做差異同步(速度快且省頻寬)，說它是CP DELUXE也可以啊 >///<

---

## ~~被git帶壞用語都git化惹~~
是說我覺得rsync跟本是git server的前身0.0
### 1. push檔案指令
```sh
rsync -avzlhP --password-file=<你的密碼檔路徑> <你要同步資料夾的路徑> rsync://<你的RSYNC的username>@<你的IP>/<你的RSYNC倉庫名稱>
```
輸入完你的東西就會跑到rsync server的資料夾裡面

### 2. pull檔案指令
```sh
rsync -avzlhP --password-file=<你的密碼檔路徑> rsync://<你的RSYNC的username>@<你的IP>/<你的RSYNC倉庫名稱>/<你的RSYNC路徑> <你要同步資料夾的路徑的PWD>
```
輸入完rsync server底下指定的資料夾就會跑到你這裡來

### 3. 偷看一下遠端上面有啥 (~~不是fetch不要亂搞啊魂淡~~)
```sh
rsync -avzlhP --list-only --exclude='/*/*/*/*' --password-file=<你的密碼檔路徑> rsync://<你的RSYNC的username>@<你的IP>/<你的RSYNC倉庫名稱>/<你的RSYNC路徑> <你要同步資料夾的路徑的PWD>
```
有點像是pull，但是是dry run的概念，就是試看看rsync server上有什麼檔案可以拉。
但我多了一個指令，--exclude，這個可以幫你排除一堆不必要的檔案，但是他的邏輯很獵奇，它需要用絕對路徑
而且莫名其妙的是你看我這樣打，但是它其實會by pass/\*/\*/\*/\*/\*/\*，你叫他略過第4層但他會略過第6層的概念，我不知道到底是什麼神邏輯。

---


簡單的說明一下上面一堆啊哩啊紮的是什麼鬼
* #### 你的密碼檔路徑 :
顧名思義，就是把密碼打在裡面啊。要注意的是只要打密碼，因為server端的rsync.secrets
那個檔案的長相是<帳號>:<密碼>。但是這個password-file就是很單純，只要<密碼>。
ex : echo '0857957' > mypasswd 裡面的東西會跟mypasswd一樣
我一開始努力設法把secret檔搞得跟rsync.secret一樣帳號密碼龍喉伊啦結果在那邊授權失敗gy老半天啊QQ。
還有個小提醒就是密碼檔的使用權限只能是600也就是只有owner有rw權限其他全部吃屎的意思
```sh
chmod 600 mypasswd
```

* #### 你的RSYNC的username :
長話短說就是你的/etc/rsync.conf
auth users的等號右邊的那個東西

* #### 你的IP :
你的RSYNC那一台機器的位置要告訴人家啊不然怎麼連。

* #### 你的RSYNC倉庫名稱 :
長話短說就是你的/etc/rsync.conf中括號裡面的東西
ex : [share]。那你的RSYNC的倉庫名稱就叫做share。

* #### 你的RSYNC路徑 :
長話短說就是你的/etc/rsync.conf中
path的等號右邊的東西為根目錄，往下延伸出去的路徑

* #### 你要同步資料夾的路徑 :
就是看你資料夾要同步去哪個地方。

* #### 你要同步資料夾的路徑的PWD :
講起來很隱晦，不過你用了就知道，反正就是假設要把/home/hmp/ 跟遠端做同步的話，那你這個就要設定/home/
(還是說你直接在/home底下然後指定./也是可以辣)


想知道參數在幹嘛可以參考一下這一篇
http://blog.xuite.net/jyoutw/xtech/20025390

---
2017/08/03
* #### --delete :
這參數好棒啊! 只要加了它，如果你把檔案刪除遠端的檔案也會自動刪除喔! 資料夾簡直同步了呢!
```sh
rsync -avzlhP --delete --password-file=<pwfile> <tmp_dir> rsync://<user>@<host>/<share>
```

---
2017/08/31
~~我居然還會回來修改筆記內容我真的好棒棒呢~~
是說因為rsync一次更新都是更新一個路徑底下的所有東西
例如
我rsync的root設定在/my-nas底下
底下有2包東西
/my-nas/a-project/b-module
/my-nas/a-project/c-module

假設我現在rsync想要新增d-module會怎樣?
/my-nas/a-project/d-module

下了以下指令

```sh
rsync -avzlhP --delete --password-file=secret /ny-nas/a-project/d-module rsync://user@192.168.1.1/my-nas
```
rsync會把/my-nas/a-project/b-module和c-module整個刪掉啊
但這不是我要的啊!!!
所以要同步之前要先確認一下遠端有資料夾可以做局部更新

所以要用2次rsync，第一次先長出資料夾，第二次再做同步
(你說可以分別有資料夾在遠端的一次rsync就好，沒資料的才用rsync做2次，好啦也是可以，但目前為求方便先一個吃全部case)

```sh
rsync -avzlhP --password-file=secret /my-nas/a-project/d-module rsync://user@192.168.1.1/my-nas

rsync -avzlhP --password-file=secret /my-nas/a-project/d-module/ rsync://user@192.168.1.1/my-nas/a-project/d-module

```

ps:順便澄清一個概念好了，/a/b/c <-這個path是指c檔案，c檔案可以是資料夾也可以是檔案，端看os給他什麼屬性，而/a/b/c/ <-通常指的是c這個資料夾底下的東西。

然而為什麼我要講這個呢？因為如果你用rsync上傳東西的資料夾寫/a/b/c他會上傳整個c資料夾，/a/b/c/他只會上傳c資料夾底下的東西啊。



