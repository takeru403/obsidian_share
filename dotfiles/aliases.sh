#!/bin/bash
# ===============================
# AI開発用エイリアス集
# ===============================
# 使用方法: source ~/dotfiles/aliases.sh

# ===============================
# AI ツール関連
# ===============================
alias cl="claude"
alias clc="claude --continue"
alias clr="claude --resume"
alias cli="claude --init"
alias gm="gemini"
alias gmp="gemini --prompt"

# ===============================
# Git関連
# ===============================
alias gs="git status"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gl="git log --oneline"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"
alias gcb="git checkout -b"

# GitHub CLI
alias ghpr="gh pr create"
alias ghpv="gh pr view"
alias ghi="gh issue create"

# ===============================
# Node.js/NPM関連
# ===============================
alias ni="npm install"
alias ns="npm start"
alias nb="npm run build"
alias nd="npm run dev"
alias nt="npm test"
alias nrd="npm run dev"
alias nrb="npm run build"
alias nrs="npm run start"

# Yarn
alias yi="yarn install"
alias ys="yarn start"
alias yb="yarn build"
alias yd="yarn dev"

# ===============================
# Python関連
# ===============================
alias py="python3"
alias pip="pip3"
alias venv="python3 -m venv"
alias activate="source venv/bin/activate"

# Poetry
alias poetry-shell="poetry shell"
alias poetry-install="poetry install"
alias poetry-add="poetry add"

# ===============================
# ディレクトリ・ファイル操作
# ===============================
alias ll="ls -la"
alias la="ls -A"
alias l="ls -CF"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# よく使うディレクトリへの移動（適宜カスタマイズ）
alias cdprojects="cd ~/Projects"
alias cddownloads="cd ~/Downloads"
alias cddesktop="cd ~/Desktop"

# ===============================
# 開発用ユーティリティ
# ===============================
# HTTPサーバー起動
alias serve="python3 -m http.server 8000"

# ポート確認
alias ports="lsof -i -P -n | grep LISTEN"

# プロセス確認
alias psg="ps aux | grep"

# Docker関連
alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"
alias di="docker images"

# ===============================
# macOS固有
# ===============================
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Finder表示
  alias finder="open ."
  
  # アプリケーション起動
  alias code="open -a 'Visual Studio Code'"
  alias chrome="open -a 'Google Chrome'"
  
  # システム情報
  alias battery="pmset -g batt"
fi

# ===============================
# 便利機能
# ===============================
# 天気予報
alias weather="curl wttr.in/Tokyo"

# パブリックIP確認
alias myip="curl ipinfo.io/ip"

# ディスク使用量
alias du1="du -h -d 1"

# ===============================
# AI開発ワークフロー
# ===============================
# 新しいプロジェクト開始
new_project() {
  if [ -z "$1" ]; then
    echo "使用方法: new_project <project-name>"
    return 1
  fi
  
  mkdir "$1" && cd "$1"
  git init
  echo "# $1" > README.md
  echo "新しいプロジェクト '$1' を作成しました"
  
  # Claude Codeを起動するか確認
  read -p "Claude Codeを起動しますか？ (y/N): " response
  if [[ "$response" =~ ^[Yy]$ ]]; then
    claude --init
    claude
  fi
}

# 複数ファイルを一度にGeminiに送る
gemini_files() {
  if [ $# -eq 0 ]; then
    echo "使用方法: gemini_files <file1> <file2> ..."
    return 1
  fi
  
  local prompt="これらのファイルについて分析してください:\n"
  for file in "$@"; do
    if [ -f "$file" ]; then
      prompt+="@$file\n"
    fi
  done
  
  echo -e "$prompt" | gemini
}

# プロジェクト統計
project_stats() {
  echo "=== プロジェクト統計 ==="
  echo "総ファイル数: $(find . -type f | wc -l)"
  echo "総行数: $(find . -name '*.js' -o -name '*.ts' -o -name '*.py' -o -name '*.md' | xargs wc -l | tail -1)"
  echo "Gitコミット数: $(git rev-list --all --count 2>/dev/null || echo '0')"
  echo "最終更新: $(git log -1 --format=%cd 2>/dev/null || echo 'N/A')"
}