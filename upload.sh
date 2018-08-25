#!/usr/bin/env bash

# 生成文件
echo '开始生成文件...'
hexo g
echo -e '生成文件成功\n\n'

# 部署文件
echo '开始部署文件...'
hexo d
echo -e '部署文件成功\n\n'

# 上传博客源码
comment=$1
if [ $# -lt 1 ]; then
    echo 'use default comment: 更新博客'
    comment='更新博客'
fi

echo '开始上传源码...'
git add .
git commit -m $comment
git push
echo '源码上传成功'