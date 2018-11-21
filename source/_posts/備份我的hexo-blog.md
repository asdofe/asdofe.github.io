---
title: 備份我的hexo blog
date: 2018-11-22 01:36:54
tags: hexo blog backup
---

hexo真的是很過分，我一直以為我deploy上github的東西，就是我當下資料夾的全部，仔細想想沒驗證就把東西毫不猶豫地git clean 真的是蠢到極點。
簡單的說就是hexo幫人家把gen好的前端檔放上去，config還是markdown file什麼的全部都幫你藏好藏滿了。天啊這也太貼心了吧，security意識滿點但是本魯
並不需要啊，請幫我備份好備份滿，就算我電腦今天開不了機，把repo 一個clone又是一尾活龍啊。

總而言之，hexo的deploy是完全不會動你的.git/的，hexo有自己的.deploy_git/去maintain那些他認為是一個網站必要元素的檔案。

所以就心臟大顆的直接開一個.git來自己做手動備份啦，hexo用master，我用其他branch嘛，這樣是不是很棒呢。

就是.gitignore自己要注意一下，不要一堆不重要的東西也commit進去了。

這樣下次只要git clone && hexo g我走到哪裡都可以寫blog惹 爽！

教學資料來源  https://blog.liebes.top/2017/03/17/hexo-backup/index.html