# 前言
参考自[子龙山人](http://book.emacs-china.org)前十天的内容(未涉及到`spacemacs`的内容)

主要涉及的配置内容有：

# 安装
  将文件下载到`.emacs.d`的目录下，先安装`cask`，主要用于`packages`的安装：
```
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
```
然后在`.emacs.d`目录下执行：`cask install`进行`Cask`文件中的packages包的安装，耐心等待！
最后打开`emacs`即可。
