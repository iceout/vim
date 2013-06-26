我的vimrc
=========

简介
----
个人vimrc存档

cycle
-----
`<Leader>a` true,false 等等循环
`:h cycle`

bufexplorer 
-----------
`<Leader>be` " 打开buf
`<Leader>bs` " 水平分割窗口
`<Leader>bv` " 垂直分割窗口

tasklist  
--------
`<Leader>t` " 查看tasklist

NERD\_commenter 
--------------
`<Leader>c<space>` " 根据第一行的状态来切换所选行的注释状态
`<Leader>cm` " 块注释
`<Leader>cc` " 行注释

EasyMotion
--
`<Leader><Leader>w` 显示序号,然后按序号跳转

Google Translate
--
`<Leader>e2c` 英译汉
`<Leader>e2c` 汉译英

既可以在normal模式下使用，也可以在visual下使用。

vim-flake8
-
<F7>检测python错误，包括是否符合PEP8.


pathogen
-

    cd ~/.vim/bundle
    git clone git://github.com/tpope/vim-fugitive.git
    :Helptags

安装插件

`#git submodule add 插件 Git 仓库地址 bundle/插件名字`
`git submodule add git://github.com/tpope/vim-markdown.git bundle/vim-markdown`

升级插件

`cd ~/.vim/bundle/vim-markdown # 将 vim-markdown 替换为需要升级的插件名字`
`git pull origin master`

升级所有插件

`cd ~/.vim`
`git submodule foreach git pull origin master`

删除插件

`git rm bundle/vim-markdown # 将 vim-markdown 替换为需要升级的插件名字`
