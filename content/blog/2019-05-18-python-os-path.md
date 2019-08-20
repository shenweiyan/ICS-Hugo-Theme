---
title: python3 中 os.path 模块常用用法总结
type: post
tags: ["Python", "编程"]
date: 2019-05-18T12:44:59.000Z
category: 编程
published: true
---

os.path：常见的路径名操作模块。原文文档链接：[https://docs.python.org/3.6/library/os.path.html](https://docs.python.org/3.6/library/os.path.html)

<a name="abspath"></a>
## abspath

> 返回一个目录的绝对路径
> Return an absolute path.


```
>>> os.path.abspath("/etc/sysconfig/selinux")
'/etc/sysconfig/selinux'
>>> os.getcwd()
'/root'
>>> os.path.abspath("python_modu")
'/root/python_modu'
```

<a name="basename"></a>
## basename

> 返回一个路径名的最终名称
> Returns the final component of a pathname


```
>>> os.path.basename("/etc/sysconfig/selinux")
'selinux'
>>> os.path.basename("/usr/local/python3/bin/python3")
'python3'
```

---

<a name="dirname"></a>
## dirname

> 返回一个目录的目录名
> Returns the directory component of a pathname


```
>>> os.path.dirname("/etc/sysconfig/selinux")
'/etc/sysconfig'
>>> os.path.dirname("/usr/local/python3/bin/python3")
'/usr/local/python3/bin'
```

---

<a name="exists"></a>
## exists

> 测试指定文件是否存在
> Test whether a path exists.  Returns False for broken symbolic links


```
>>> os.path.exists("/home/egon")
False
>>> os.path.exists("/root")
True
>>> os.path.exists("/usr/bin/python")
True
```

---

<a name="getatime"></a>
## getatime

> 得到指定文件最后一次的访问时间
> Return the last access time of a file, reported by os.stat().


```
>>> os.stat("/root/test.sh")
os.stat_result(st_mode=33261, st_ino=100684935, st_dev=2050, st_nlink=1, st_uid=0, st_gid=0, st_size=568, st_atime=1498117664, st_mtime=1496629059, st_ctime=1498117696)
>>> os.path.getatime("/root/test.sh")
1498117664.2808378
```

---

<a name="getctime"></a>
## getctime

> 得到指定文件最后一次的改变时间
> Return the metadata change time of a file, reported by os.stat().


```
>>> os.stat("/root/test.sh")
os.stat_result(st_mode=33261, st_ino=100684935, st_dev=2050, st_nlink=1, st_uid=0, st_gid=0, st_size=568, st_atime=1498117664, st_mtime=1496629059, st_ctime=1498117696)
>>> os.path.getctime("/root/test.sh")
1498117696.039542
```

---

<a name="getmtime"></a>
## getmtime

> 得到指定文件最后一次的修改时间
> Return the last modification time of a file, reported by os.stat().


```
>>> os.stat("/root/test.sh")
os.stat_result(st_mode=33261, st_ino=100684935, st_dev=2050, st_nlink=1, st_uid=0, st_gid=0, st_size=568, st_atime=1498117664, st_mtime=1496629059, st_ctime=1498117696)
>>> os.path.getmtime("/root/test.sh")
1496629059.9313989
```

---

<a name="getsize"></a>
## getsize

> 得到得到文件的大小
> Return the size, in bytes, of path. Raise OSError if the file does not exist or is inaccessible.


```
>>> os.stat("/root/test.sh")
os.stat_result(st_mode=33261, st_ino=100684935, st_dev=2050, st_nlink=1, st_uid=0, st_gid=0, st_size=568, st_atime=1498117664, st_mtime=1496629059, st_ctime=1498117696)
>>> os.path.getsize("/root/test.sh")
568
```

---

<a name="isabs"></a>
## isabs

> 测试参数是否是绝对路径
> Return True if path is an absolute pathname. On Unix, that means it begins with a slash, on Windows that it begins with a (back)slash after chopping off a potential drive letter.


```
>>> os.path.isabs("python_modu")
False
>>> os.path.isabs("/etc/sysconfig")
True
```

---

<a name="isfile"></a>
## isfile

> 测试指定参数是否是一个文件
> Return True if path is an existing regular file. This follows symbolic links, so both islink() and isfile() can be true for the same path.


```
>>> os.path.isfile("/home")
False
>>> os.path.isfile("/etc/sysconfig/selinux")
True
```

---

<a name="isdir"></a>
## isdir

> 测试指定参数是否是目录名
> Return True if path is an existing directory. This follows symbolic links, so both islink() and isdir() can be true for the same path.


```
>>> os.path.isdir("/etc/sysconfig/selinux")
False
>>> os.path.isdir("/home")
True
```

---

<a name="islink"></a>
## islink

> 测试指定参数是否是一个软链接
> Return True if path refers to an existing directory entry that is a symbolic link. Always False if symbolic links are not supported by the Python runtime.


```
>>> os.path.islink("/etc/sysconfig/selinux")
True
>>> os.path.islink("/etc/sysconfig/nfs")
False
```

---

<a name="ismount"></a>
## ismount

> 测试指定参数是否是挂载点
> Return True if pathname path is a mount point: a point in a file system where a different file system has been mounted. The function checks whether path’s parent, path/.., is on a different device than path, or whether path/.. and path point to the same i-node on the same device — this should detect mount points for all Unix and POSIX variants.


```
>>> os.path.ismount("/mnt/cdrom")
False
以上是未挂载光盘，现在把光盘挂载到/mnt/cdrom下，再进行测试
>>> os.path.ismount("/mnt/cdrom")
True
```

---

<a name="join"></a>
## join

> join(a, *p)：将目录名和文件的基名拼接成一个完整的路径
> Join one or more path components intelligently.


```
>>> for filename in os.listdir("/home"):
...     print(os.path.join("/tmp",filename))
... 
/tmp/a
/tmp/f1.txt
```

---

<a name="realpath"></a>
## realpath

> 返回指定文件的标准路径，而非软链接所在的路径
> Return the canonical path of the specified filename, eliminating any symbolic links encountered in the path (if they are supported by the operating system).


```
>>> os.path.realpath("/etc/sysconfig/selinux")
'/etc/selinux/config'
>>> os.path.realpath("/usr/bin/python")
'/usr/bin/python2.7'
```

---

<a name="samefile"></a>
## samefile

> 测试两个路径是否指向同一个文件
> Return True if both pathname arguments refer to the same file or directory. This is determined by the device number and i-node number and raises an exception if an os.stat() call on either pathname fails.


```
-
```

---

<a name="sameopenfile"></a>
## sameopenfile

> 测试两个打开的文件是否指向同一个文件
> Return True if the file descriptors fp1 and fp2 refer to the same file.


```
-
```

---

<a name="split"></a>
## split

> 分割目录名，返回由其目录名和基名给成的元组
> Split the pathname path into a pair, (head, tail) where tail is the last pathname component and head is everything leading up to that. The tail part will never contain a slash; if path ends in a slash, tail will be empty. If there is no slash in path, head will be empty. If path is empty, both head and tail are empty. Trailing slashes are stripped from head unless it is the root (one or more slashes only). In all cases, join(head, tail) returns a path to the same location as path (but the strings may differ).


```
>>> os.path.split("/tmp/f1.txt")
('/tmp', 'f1.txt')
>>> os.path.split("/home/test.sh")
('/home', 'test.sh')
```

---

<a name="splitext"></a>
## splitext

> 分割文件名，返回由文件名和扩展名组成的元组
> Split the pathname path into a pair (root, ext) such that root + ext == path, and ext is empty or begins with a period and contains at most one period. Leading periods on the basename are ignored; splitext('.cshrc') returns ('.cshrc', '').


```
>>> os.path.splitext("/home/test.sh")
('/home/test', '.sh')
>>> os.path.splitext("/tmp/f1.txt")
('/tmp/f1', '.txt')
```
