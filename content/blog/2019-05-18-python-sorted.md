---
title: 利用 python 的 sorted 函数对字典按 key 排序和按 value 排序
type: post
tags: ["Python", "编程"]
date: 2019-05-18T12:50:51.000Z
category: 编程
published: true
---

我们知道 Python 的内置 dictionary 数据类型是无序的，通过 key 来获取对应的 value。可是有时我们需要对 dictionary 中的 item 进行排序输出，可能根据 key，也可能根据 value 来排。到底有多少种方法可以实现对 dictionary 的内容进行排序输出呢？下面摘取了使用 sorted 函数实现对 dictionary 的内容进行排序输出一些精彩的解决办法。

<a name="5502fb94"></a>
## 1. sorted函数按key值对字典排序

先基本介绍一下 sorted 函数，`sorted(iterable,key,reverse)`，sorted一共有 `iterable`,`key`,`reverse` 这三个参数。

- 其中 iterable 表示可以迭代的对象，例如可以是 dict.items()、dict.keys()等。
- key 是一个函数，用来选取参与比较的元素。
- reverse 则是用来指定排序是倒序还是顺序，reverse=true 则是倒序，reverse=false 时则是顺序，默认时 reverse=false。

要按key值对字典排序，则可以使用如下语句：
```
In [1]: d = {"lilee":25, "wangyuan":21, "liquan":32, "zhangsan":18, "lisi":28}

In [2]: sorted(d.keys())
Out[2]: ['lilee', 'liquan', 'lisi', 'wangyuan', 'zhangsan']
```

直接使用 `sorted(d.keys())` 就能按 key 值对字典排序，这里是按照顺序对 key 值排序的，如果想按照倒序排序的话，则只要将 reverse 置为 true 即可。

<a name="f602d254"></a>
## 2. sorted函数按value值对字典排序

在 python2.4 前，sorted() 和 list.sort() 函数没有提供 key 参数，但是提供了 cmp 参数来让用户指定比较函数。此方法在其他语言中也普遍存在。

在 python2.x 中 cmp 参数指定的函数用来进行元素间的比较。此函数需要 2 个参数，然后返回负数表示小于，0 表示等于，正数表示大于。

在 python3.0 中，cmp 参数被彻底的移除了，从而简化和统一语言，减少了高级比较和 `__cmp__` 方法的冲突。

- cmp 参数（python3 中已经被移除，不推荐）
```
In [3]: sorted(d.items(), lambda x, y: cmp(x[1], y[1]), reverse=True)
Out[3]: 
[('liquan', 32),
 ('lisi', 28),
 ('lilee', 25),
 ('wangyuan', 21),
 ('zhangsan', 18)]
```

- key 参数（推荐）
```
In [4]: sorted(d.items(), key=lambda item:item[1], reverse=True)
Out[4]: 
[('liquan', 32),
 ('lisi', 28),
 ('lilee', 25),
 ('wangyuan', 21),
 ('zhangsan', 18)]
```

1. 这里的 `d.items()` 实际上是将 d 转换为可迭代对象，迭代对象的元素为 `('liquan', 32)、('lisi', 28)、......、('zhangsan', 18)`。
1. items() 方法将字典的元素转化为了元组，而这里 key 参数对应的 lambda 表达式的意思则是选取元组中的第二个元素作为比较参数（如果写作 `key=lambda item:item[0]` 的话则是选取第一个元素作为比较对象，也就是 key 值作为比较对象。`lambda x:y` 中 x 表示输出参数，y 表示 lambda 函数的返回值），所以采用这种方法可以对字典的 value 进行排序。
1. 注意排序后的返回值是一个 list，而原字典中的名值对被转换为了 list 中的元组。
