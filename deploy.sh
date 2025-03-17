#!/bin/bash

set -e  # エラー時にスクリプトを止める

echo "🚀 Starting Hugo Deployment"

# サブモジュールを更新（テーマなど）
git submodule update --init --recursive

# Hugo ビルド
hugo -d public

# `gh-pages` にデプロイ
git worktree add ../gh-pages gh-pages
rsync -av --delete public/ ../gh-pages/
cd ../gh-pages

git add .
git commit -m "Deploy $(date +'%Y-%m-%d %H:%M:%S')"
git push origin gh-pages

echo "✅ Deployment completed!"
