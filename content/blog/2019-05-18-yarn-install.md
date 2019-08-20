---
title: 从 Galaxy Project 用户界面聊聊 Linux 下 Yarn 安装
type: post
tags: ["软件", "软件"]
date: 2019-05-18T12:19:29.000Z
category: 软件
published: true
---

Galaxy 从 release 18.01 版本起，为其用户界面提供支持的客户端代码架构已经过了彻底的变更。 基础代码库已经转换为 ES6，同时启用了 Yarn 支持代码的构建和依赖管理，启用 Prettier 用于确保代码的一致性格式化，并且把 VueJS 框架也集成到了其中。

> The architecture for the client code that powers the Galaxy user interface has been significantly overhauled. The code base has been converted to [ES6](http://es6-features.org/), [Yarn](https://github.com/yarnpkg/yarn) now powers the build and dependency management of the code, [Prettier](https://prettier.io/) is now used to ensure consistent code formatting, and the [VueJS](https://vuejs.org/) framework has been integrated. Taken together, these changes are enabling Galaxy developers to write usable, responsive client code more quickly and concisely than previously possible.
> 
> From [https://docs.galaxyproject.org/en/master/releases/18.01_announce.html](https://docs.galaxyproject.org/en/master/releases/18.01_announce.html)


Yarn 是由 Facebook、Google、Exponent 和 Tilde 联合推出了一个新的 JS 包管理工具 ，正如官方文档中写的，Yarn 是为了弥补 npm 的一些缺陷而出现的。Galaxy 的自定义用户界面需要确保 Yarn 正常可用，这里是 Yarn 在 CentOS 7 下安装的一些记录。

Yarn 官方提供的基本上都是基于 sudo 权限的安装方法（https://yarnpkg.com/en/docs/install），使用 tar.gz 源码指定路径的安装方法目前没有找到。虽然教程里面有提到说直接下载，然后解压即可，但经测试这种方法会导致 yarn 运行时，找不到相关的 lib。

各个版本源码下载地址：[https://github.com/yarnpkg/yarn/releases](https://github.com/yarnpkg/yarn/releases)

以下是测试可行可手动更改安装目录的方法，此为备忘。

- yarn 安装前需要安装 node.js，并且 node 可以在 `$PATH` 中找到。
- 如果存在`~/.yarn`，需要先执行`rm -rf ~/.yarn`，再安装。

```
shenweiyan@ecs-steven 13:38:05 /home/shenweiyan
$ curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.12.3
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7041    0  7041    0     0   4115      0 --:--:--  0:00:01 --:--:--  4115
Installing Yarn!
> Downloading tarball...

[1/2]: https://yarnpkg.com/downloads/1.12.3/yarn-v1.12.3.tar.gz --> /tmp/yarn.tar.gz.tQbHw7wPEA
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    93  100    93    0     0     23      0  0:00:04  0:00:04 --:--:--    23
100   609    0   609    0     0    132      0 --:--:--  0:00:04 --:--:--  1750
100 1139k  100 1139k    0     0  16471      0  0:01:10  0:01:10 --:--:-- 80506

[2/2]: https://yarnpkg.com/downloads/1.12.3/yarn-v1.12.3.tar.gz.asc --> /tmp/yarn.tar.gz.tQbHw7wPEA.asc
100    97  100    97    0     0    480      0 --:--:-- --:--:-- --:--:--   480
100   613    0   613    0     0    618      0 --:--:-- --:--:-- --:--:--  1046
100   832  100   832    0     0    643      0  0:00:01  0:00:01 --:--:--   643
> Verifying integrity...
gpg: Signature made Wed 07 Nov 2018 11:13:31 PM CST using RSA key ID B6FF4DE3
gpg: Good signature from "Yarn Packaging <yarn@dan.cx>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 72EC F46A 56B4 AD39 C907  BBB7 1646 B01B 86E5 0310
     Subkey fingerprint: E219 30C4 D0A4 AA46 1858  1F7A E074 D16E B6FF 4DE3
> GPG signature looks good
> Extracting to ~/.yarn...
> Adding to $PATH...
> We've added the following to your /home/shenweiyan/.bashrc
> If this isn't the profile of your current shell then please add the following to your correct profile:

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

> Successfully installed Yarn 1.12.3! Please open another terminal where the `yarn` command will now be available.
```

手动转移 yarn 至指定目录：
```
$ mv ~/.yarn /usr/local/software/yarn-1.12.3/
```

添加 yarn 到 $PATH 环境变量：
```
export PATH="/usr/local/software/yarn-1.12.3/bin:$PATH"
```

最后，刷新环境变量，完成安装。
```
shenweiyan@ecs-steven 13:56:13 /home/shenweiyan
$ export PATH="/usr/local/software/yarn-1.12.3/bin:$PATH"
shenweiyan@ecs-steven 13:56:15 /home/shenweiyan
$ which yarn
/usr/local/software/yarn-1.12.3/bin/yarn
shenweiyan@ecs-steven 13:56:18 /home/shenweiyan
$ yarn -h

  Usage: yarn [command] [flags]

  Displays help information.

  Options:

    --cache-folder <path>               specify a custom folder that must be used to store the yarn cache
    --check-files                       install will verify file tree of packages for consistency
    --cwd <cwd>                         working directory to use (default: /home/shenweiyan)
    --disable-pnp                       disable the Plug'n'Play installation
    --emoji [bool]                      enable emoji in output (default: false)
    --enable-pnp, --pnp                 enable the Plug'n'Play installation
    
    ......

    - workspace
    - workspaces

  Run `yarn help COMMAND` for more information on specific commands.
  Visit https://yarnpkg.com/en/docs/cli/ to learn more about Yarn.
```
