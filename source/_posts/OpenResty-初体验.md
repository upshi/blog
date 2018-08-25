---
title: OpenResty 初体验
date: 2018-08-25 22:53:35
tags:
- OpenResty
categories:
- OpenResty
---

## OpenResty是什么？
引用[官方网站](http://openresty.org/cn/)对OpenResty的介绍：

OpenResty® 是一个基于 Nginx 与 Lua 的高性能 Web 平台，其内部集成了大量精良的 Lua 库、第三方模块以及大多数的依赖项。用于方便地搭建能够处理超高并发、扩展性极高的动态 Web 应用、Web 服务和动态网关。

OpenResty® 通过汇聚各种设计精良的 Nginx 模块（主要由 OpenResty 团队自主开发），从而将 Nginx 有效地变成一个强大的通用 Web 应用平台。这样，Web 开发人员和系统工程师可以使用 Lua 脚本语言调动 Nginx 支持的各种 C 以及 Lua 模块，快速构造出足以胜任 10K 乃至 1000K 以上单机并发连接的高性能 Web 应用系统。

OpenResty® 的目标是让你的Web服务直接跑在 Nginx 服务内部，充分利用 Nginx 的非阻塞 I/O 模型，不仅仅对 HTTP 客户端请求,甚至于对远程后端诸如 MySQL、PostgreSQL、Memcached 以及 Redis 等都进行一致的高性能响应。

## 安装
[官方安装向导](http://openresty.org/cn/installation.html)有详细的安装介绍，建议通过源码的方式进行安装，可以自定义很多配置。

configure过程中发现缺少zlib包，在Kali系统中使用如下命令安装
```s
sudo apt-get install zlib1g-dev
```

安装完毕后，目录结构如下：
```s
upshi@kali:/opt/openresty/bin$ ls -la
总用量 168
drwxr-xr-x 2 root root  4096 8月  25 22:42 .
drwxr-xr-x 8 root root  4096 8月  25 22:42 ..
-rwxr-xr-x 1 root root 19109 8月  25 22:42 md2pod.pl
-rwxr-xr-x 1 root root 15655 8月  25 22:42 nginx-xml2pod
lrwxrwxrwx 1 root root    31 8月  25 22:42 openresty -> /opt/openresty/nginx/sbin/nginx
-rwxr-xr-x 1 root root 63530 8月  25 22:42 opm
-rwxr-xr-x 1 root root 29485 8月  25 22:42 resty
-rwxr-xr-x 1 root root 14957 8月  25 22:42 restydoc
-rwxr-xr-x 1 root root  8452 8月  25 22:42 restydoc-index
```

## OpenResty能够做什么？
OpenResty成功的把Lua语言嵌入了Nginx，用Lua作为“胶水语言”粘合Nginx的各个模块和底层接口，以脚本的方式直接实现复杂的HTTP/TCP/UDP的业务逻辑，降低了Web Server---特别是高性能Web Server的开发门槛。

## OpenResty的组成
OpenResty的核心组件有3个，分别是:
- Nginx: 高性能的Web服务器
- LuaJIT: 高效的Lua语言解释器/编译器(Just-IN-Time Compiler)
- ngx_lua: 以模块的方式让Lua语言嵌入在Nginx里执行

使用以上三个组件，已经可以完成相当多的网络应用开发工作。除此以外，它还包含了一些其它的非常有用的Nginx模块和lua-resty库，较常用的有：

- ngx_echo: 提供一系列“echo”风格的Nginx指令和变量
- ngx_set_misc: 增强的“set_xxx”指令，用来操作变量
- ngx_headers_more: 更方便的处理HTTP请求头和响应头的指令
- lua_cjson: C实现的快速解析JSON格式数据的Lua库
- lua_string: md5/sha1/sha256等字符串功能
- lua_lrucache: 高效的LRU缓存
- lua_lock: 基于共享内存的非阻塞锁

此外，OpenResty里还有几个辅助开发、调试和运维的工具，例如:
- opm: 类似rpm, npm的包管理工具
- resty-cli: 以命令行的形式直接执行OpenResty/Lua程序
- restydoc: 类似man的参考手册，非常详细
