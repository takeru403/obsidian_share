# ツール使用方法ガイド

このドキュメントでは、プロジェクトで使用する各ツールの詳しい使用方法について説明します。

## 目次

1. [フロントエンド開発ツール](#1-フロントエンド開発ツール)
2. [バックエンド開発ツール](#2-バックエンド開発ツール)
3. [データベース管理ツール](#3-データベース管理ツール)
4. [AI支援ツール](#4-ai支援ツール)
5. [ターミナル・シェル環境](#5-ターミナルシェル環境)
6. [バージョン管理ツール](#6-バージョン管理ツール)
7. [インフラ・デプロイメントツール](#7-インフラデプロイメントツール)
8. [パッケージ管理ツール](#8-パッケージ管理ツール)

---

## 1. フロントエンド開発ツール

### Next.js

**基本的なプロジェクト作成**
```bash
# 新しいNext.jsプロジェクトを作成
npx create-next-app@latest my-next-app --typescript --tailwind --eslint --app

# プロジェクトディレクトリに移動
cd my-next-app

# 開発サーバーを起動
npm run dev
```

**基本的なファイル構造**
```
my-next-app/
├── app/                 # App Router（Next.js 13+）
│   ├── globals.css     # グローバルスタイル
│   ├── layout.tsx      # ルートレイアウト
│   ├── page.tsx        # ホームページ
│   └── loading.tsx     # ローディングページ
├── components/         # 再利用可能なコンポーネント
├── public/            # 静的ファイル
├── next.config.js     # Next.js設定
└── package.json       # 依存関係
```

**よく使うコマンド**
```bash
npm run dev          # 開発サーバー起動（localhost:3000）
npm run build        # プロダクションビルド
npm run start        # プロダクションサーバー起動
npm run lint         # ESLintでコード品質チェック
```

**基本的なページ作成**
```typescript
// app/about/page.tsx
export default function About() {
  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold">About Page</h1>
      <p className="mt-4">This is the about page.</p>
    </div>
  )
}
```

**APIルート作成**
```typescript
// app/api/hello/route.ts
import { NextRequest, NextResponse } from 'next/server'

export async function GET(request: NextRequest) {
  return NextResponse.json({ message: 'Hello, World!' })
}

export async function POST(request: NextRequest) {
  const body = await request.json()
  return NextResponse.json({ received: body })
}
```

### Tailwind CSS

**基本的な使用方法**
```html
<!-- ユーティリティクラスを使用 -->
<div class="bg-blue-500 text-white p-4 rounded-lg shadow-md">
  <h2 class="text-xl font-bold mb-2">Card Title</h2>
  <p class="text-sm">Card content</p>
</div>
```

**レスポンシブデザイン**
```html
<!-- モバイルファースト -->
<div class="w-full md:w-1/2 lg:w-1/3 xl:w-1/4">
  <p class="text-sm md:text-base lg:text-lg">Responsive text</p>
</div>
```

**カスタム設定（tailwind.config.js）**
```javascript
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        primary: '#1234567',
        secondary: '#abcdef',
      },
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
```

### TypeScript

**基本的な型定義**
```typescript
// types/index.ts
export interface User {
  id: number
  name: string
  email: string
  createdAt: Date
}

export interface ApiResponse<T> {
  data: T
  message: string
  success: boolean
}
```

**React Componentでの使用**
```typescript
// components/UserCard.tsx
import { User } from '@/types'

interface UserCardProps {
  user: User
  onDelete: (id: number) => void
}

export const UserCard: React.FC<UserCardProps> = ({ user, onDelete }) => {
  return (
    <div className="border p-4 rounded">
      <h3>{user.name}</h3>
      <p>{user.email}</p>
      <button onClick={() => onDelete(user.id)}>Delete</button>
    </div>
  )
}
```

---

## 2. バックエンド開発ツール

### FastAPI

**基本的なアプリケーション作成**
```python
# main.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List, Optional

app = FastAPI()

# データモデル定義
class User(BaseModel):
    id: Optional[int] = None
    name: str
    email: str

class UserCreate(BaseModel):
    name: str
    email: str

# インメモリデータベース（デモ用）
users_db: List[User] = []

# ルート定義
@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/users", response_model=List[User])
async def get_users():
    return users_db

@app.post("/users", response_model=User)
async def create_user(user: UserCreate):
    new_user = User(id=len(users_db) + 1, **user.dict())
    users_db.append(new_user)
    return new_user

@app.get("/users/{user_id}", response_model=User)
async def get_user(user_id: int):
    for user in users_db:
        if user.id == user_id:
            return user
    raise HTTPException(status_code=404, detail="User not found")

@app.put("/users/{user_id}", response_model=User)
async def update_user(user_id: int, user_update: UserCreate):
    for i, user in enumerate(users_db):
        if user.id == user_id:
            updated_user = User(id=user_id, **user_update.dict())
            users_db[i] = updated_user
            return updated_user
    raise HTTPException(status_code=404, detail="User not found")

@app.delete("/users/{user_id}")
async def delete_user(user_id: int):
    for i, user in enumerate(users_db):
        if user.id == user_id:
            del users_db[i]
            return {"message": "User deleted"}
    raise HTTPException(status_code=404, detail="User not found")
```

**サーバー起動**
```bash
# 開発サーバー起動（ホットリロード有効）
uvicorn main:app --reload

# 本番サーバー起動
uvicorn main:app --host 0.0.0.0 --port 8000
```

**APIドキュメント確認**
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

**データベース統合（SQLAlchemy）**
```python
# database.py
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

SQLALCHEMY_DATABASE_URL = "sqlite:///./test.db"

engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

class User(Base):
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    email = Column(String, unique=True, index=True)

Base.metadata.create_all(bind=engine)
```

### Poetry

**プロジェクト初期化**
```bash
# 新しいプロジェクト作成
poetry new my-project
cd my-project

# 既存のプロジェクトでPoetryを初期化
poetry init
```

**依存関係管理**
```bash
# パッケージ追加
poetry add fastapi
poetry add uvicorn[standard]
poetry add --group dev pytest black flake8

# パッケージ削除
poetry remove package-name

# 依存関係一覧表示
poetry show

# 依存関係ツリー表示
poetry show --tree

# インストール（pyproject.tomlから）
poetry install

# 仮想環境でコマンド実行
poetry run python main.py
poetry run pytest

# 仮想環境をアクティベート
poetry shell
```

**pyproject.toml設定例**
```toml
[tool.poetry]
name = "my-fastapi-project"
version = "0.1.0"
description = "A FastAPI project"
authors = ["Your Name <you@example.com>"]
readme = "README.md"

[tool.poetry.dependencies]
python = "^3.9"
fastapi = "^0.104.0"
uvicorn = {extras = ["standard"], version = "^0.24.0"}
sqlalchemy = "^2.0.0"
pydantic = "^2.0.0"

[tool.poetry.group.dev.dependencies]
pytest = "^7.4.0"
black = "^23.0.0"
flake8 = "^6.0.0"
mypy = "^1.5.0"

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```

---

## 3. データベース管理ツール

### PostgreSQL

**基本的な操作**
```bash
# PostgreSQLに接続
psql -U username -d database_name

# データベース一覧表示
\l

# データベース作成
CREATE DATABASE myproject;

# データベースに接続
\c myproject

# テーブル一覧表示
\dt

# テーブル構造表示
\d table_name

# PostgreSQLから終了
\q
```

**基本的なSQL操作**
```sql
-- テーブル作成
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- データ挿入
INSERT INTO users (name, email) VALUES 
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com');

-- データ検索
SELECT * FROM users;
SELECT name, email FROM users WHERE id = 1;

-- データ更新
UPDATE users SET name = 'John Smith' WHERE id = 1;

-- データ削除
DELETE FROM users WHERE id = 1;

-- テーブル削除
DROP TABLE users;
```

**バックアップとリストア**
```bash
# データベースバックアップ
pg_dump -U username database_name > backup.sql

# データベースリストア
psql -U username database_name < backup.sql

# 圧縮バックアップ
pg_dump -U username -Fc database_name > backup.dump

# 圧縮バックアップからリストア
pg_restore -U username -d database_name backup.dump
```

### SQLite

**基本的な操作**
```bash
# SQLiteデータベースに接続
sqlite3 mydatabase.db

# データベース情報表示
.databases

# テーブル一覧表示
.tables

# テーブル構造表示
.schema table_name

# CSVファイルからデータインポート
.mode csv
.import data.csv table_name

# 結果をCSVファイルにエクスポート
.headers on
.mode csv
.output results.csv
SELECT * FROM table_name;
.output stdout

# SQLiteから終了
.quit
```

---

## 4. AI支援ツール

### Claude Code

**基本的な使用方法**
```bash
# Claude Codeを起動
claude-code

# ファイルを開いて編集
claude-code edit filename.py

# プロジェクト全体でClaude Codeを起動
cd my-project
claude-code .

# 特定のプロンプトでClaude Codeを実行
claude-code --prompt "この関数を最適化してください" function.py
```

**効果的な使い方のコツ**
- 具体的で明確な指示を出す
- コードの文脈を提供する
- 段階的にタスクを分割する
- エラーメッセージを共有する

### Gemini CLI

**基本的な使用方法**
```bash
# Gemini CLIの認証
gemini auth login

# テキストプロンプト
gemini generate "Python でFizzBuzzを実装してください"

# ファイルを入力として使用
gemini generate --file code.py "このコードをレビューしてください"

# 画像を分析
gemini generate --image screenshot.png "この画面の問題点を教えてください"

# チャット形式での対話
gemini chat

# 設定表示
gemini config list

# モデル一覧表示
gemini models list
```

**設定ファイル（~/.gemini/config.yaml）**
```yaml
model: gemini-pro
temperature: 0.7
max_tokens: 1000
system_prompt: "あなたは優秀なソフトウェアエンジニアです。"
```

---

## 5. ターミナル・シェル環境

### iTerm2（macOS）

**基本的な操作**
```bash
# 新しいタブを開く: Cmd + T
# タブを閉じる: Cmd + W
# タブ間の移動: Cmd + 数字 or Cmd + Left/Right
# 画面分割（垂直）: Cmd + D
# 画面分割（水平）: Cmd + Shift + D
# 分割画面間の移動: Cmd + Option + 矢印キー
```

**便利な設定**
1. Preferences → Profiles → Colors でテーマ変更
2. Preferences → Profiles → Text でフォント設定
3. Preferences → Keys でキーバインド設定

### tmux

**基本的な操作**
```bash
# 新しいセッション作成
tmux new-session -s session_name

# セッション一覧表示
tmux list-sessions

# セッションにアタッチ
tmux attach-session -t session_name

# セッションをデタッチ: Ctrl+b, d
```

**ウィンドウ操作**
```bash
# 新しいウィンドウ作成: Ctrl+b, c
# ウィンドウ一覧表示: Ctrl+b, w
# ウィンドウ切り替え: Ctrl+b, 数字
# ウィンドウ名前変更: Ctrl+b, ,
# ウィンドウ閉じる: Ctrl+b, &
```

**ペイン操作**
```bash
# 縦分割: Ctrl+b, %
# 横分割: Ctrl+b, "
# ペイン切り替え: Ctrl+b, 矢印キー
# ペインサイズ変更: Ctrl+b, Ctrl+矢印キー
# ペイン閉じる: Ctrl+b, x
```

**設定ファイル（~/.tmux.conf）**
```bash
# マウス操作を有効化
set -g mouse on

# プレフィックスキーをCtrl+aに変更
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# ウィンドウ番号を1から開始
set -g base-index 1
setw -g pane-base-index 1

# ステータスバーの設定
set -g status-bg colour234
set -g status-fg white
set -g status-left '#[fg=green]#S '
set -g status-right '#[fg=yellow]%Y-%m-%d %H:%M'

# 設定ファイルを再読み込み: Ctrl+b, r
bind r source-file ~/.tmux.conf \; display "Config reloaded!"
```

### Zsh

**Oh My Zshプラグイン**
```bash
# .zshrcファイルの設定例
ZSH_THEME="robbyrussell"

plugins=(
  git
  docker
  kubectl
  npm
  poetry
  python
  vscode
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# カスタムエイリアス
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'

# カスタム関数
function mkcd() {
  mkdir -p "$1" && cd "$1"
}

function extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
```

---

## 6. バージョン管理ツール

### Git

**基本的なワークフロー**
```bash
# リポジトリを複製
git clone https://github.com/user/repo.git
cd repo

# 現在の状態確認
git status

# ファイルをステージング
git add filename.txt
git add .  # 全ファイル

# コミット
git commit -m "Add new feature"

# リモートに送信
git push origin main

# リモートから取得
git pull origin main
```

**ブランチ操作**
```bash
# ブランチ一覧表示
git branch

# 新しいブランチ作成・切り替え
git checkout -b feature/new-feature

# ブランチ切り替え
git checkout main

# ブランチマージ
git checkout main
git merge feature/new-feature

# ブランチ削除
git branch -d feature/new-feature
```

**履歴管理**
```bash
# コミット履歴表示
git log
git log --oneline
git log --graph --oneline --all

# 特定のコミットの差分表示
git show commit-hash

# ファイルの変更履歴
git log -p filename.txt

# 変更を元に戻す
git checkout -- filename.txt  # 作業ディレクトリの変更を破棄
git reset HEAD filename.txt    # ステージングを解除
git reset --hard HEAD~1        # 直前のコミットを取り消し
```

### GitHub CLI

**基本的なリポジトリ操作**
```bash
# リポジトリ作成
gh repo create my-project --public --clone

# リポジトリ複製
gh repo clone user/repo

# リポジトリ情報表示
gh repo view

# リポジトリをブラウザで開く
gh repo view --web
```

**Issue管理**
```bash
# Issue一覧表示
gh issue list

# 新しいIssue作成
gh issue create --title "Bug: Login not working" --body "Description of the issue"

# Issue表示
gh issue view 123

# Issue閉じる
gh issue close 123

# Issueをブラウザで開く
gh issue view 123 --web
```

**Pull Request管理**
```bash
# PR一覧表示
gh pr list

# 新しいPR作成
gh pr create --title "Add new feature" --body "Description of changes"

# PR表示
gh pr view 456

# PRをチェックアウト
gh pr checkout 456

# PRマージ
gh pr merge 456 --merge  # または --squash, --rebase

# PRをブラウザで開く
gh pr view 456 --web
```

**Actions（CI/CD）管理**
```bash
# ワークフロー一覧表示
gh workflow list

# ワークフロー実行
gh workflow run "CI"

# 実行履歴表示
gh run list

# 実行ログ表示
gh run view 123456789
```

---

## 7. インフラ・デプロイメントツール

### Docker

**基本的な操作**
```bash
# イメージ一覧表示
docker images

# コンテナ一覧表示
docker ps       # 実行中のコンテナ
docker ps -a    # 全てのコンテナ

# イメージ取得
docker pull nginx:latest

# コンテナ実行
docker run -d -p 8080:80 --name my-nginx nginx:latest

# コンテナ停止・開始・再起動
docker stop my-nginx
docker start my-nginx
docker restart my-nginx

# コンテナに接続
docker exec -it my-nginx bash

# コンテナ削除
docker rm my-nginx

# イメージ削除
docker rmi nginx:latest

# システム全体のクリーンアップ
docker system prune -a
```

**Dockerfileの作成**
```dockerfile
# Dockerfile
FROM node:18-alpine

# 作業ディレクトリ設定
WORKDIR /app

# 依存関係ファイルをコピー
COPY package*.json ./

# 依存関係インストール
RUN npm ci --only=production

# アプリケーションファイルをコピー
COPY . .

# ビルド
RUN npm run build

# ポート公開
EXPOSE 3000

# ユーザー作成（セキュリティ向上）
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
USER nextjs

# アプリケーション実行
CMD ["npm", "start"]
```

**イメージビルド**
```bash
# イメージビルド
docker build -t my-app .

# タグ付きビルド
docker build -t my-app:v1.0.0 .

# イメージ実行
docker run -p 3000:3000 my-app
```

**Docker Compose**
```yaml
# docker-compose.yml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    depends_on:
      - db
    volumes:
      - ./logs:/app/logs

  db:
    image: postgres:15
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  postgres_data:
```

**Docker Compose操作**
```bash
# サービス起動
docker-compose up -d

# ログ確認
docker-compose logs -f web

# サービス停止
docker-compose down

# ボリュームも削除
docker-compose down -v

# 特定のサービスのみ再起動
docker-compose restart web
```

### Terraform

**基本的なプロジェクト構造**
```
terraform-project/
├── main.tf              # メインの設定
├── variables.tf         # 変数定義
├── outputs.tf          # 出力値定義
├── terraform.tfvars    # 変数値
└── modules/            # 再利用可能なモジュール
    └── vpc/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

**基本的な設定例（AWS）**
```hcl
# main.tf
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC作成
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# サブネット作成
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-${count.index + 1}"
  }
}

# データソース
data "aws_availability_zones" "available" {
  state = "available"
}
```

**変数定義**
```hcl
# variables.tf
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
```

**出力値定義**
```hcl
# outputs.tf
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}
```

**基本的な操作**
```bash
# Terraformプロジェクト初期化
terraform init

# 実行計画表示
terraform plan

# インフラ適用
terraform apply

# リソース削除
terraform destroy

# 現在の状態確認
terraform show

# 状態一覧表示
terraform state list

# 設定フォーマット
terraform fmt

# 設定検証
terraform validate
```

### Vercel CLI

**基本的なデプロイ**
```bash
# Vercelにログイン
vercel login

# プロジェクトをデプロイ
cd my-next-app
vercel

# プロダクションデプロイ
vercel --prod

# 環境変数設定
vercel env add DATABASE_URL production

# 環境変数一覧表示
vercel env ls

# プロジェクト一覧表示
vercel list

# デプロイ履歴表示
vercel ls my-project

# ログ確認
vercel logs my-project

# ドメイン管理
vercel domains add my-domain.com
vercel domains ls
```

**設定ファイル（vercel.json）**
```json
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/next"
    }
  ],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "/api/$1"
    }
  ],
  "env": {
    "DATABASE_URL": "@database_url"
  },
  "functions": {
    "app/api/**/*.ts": {
      "maxDuration": 30
    }
  }
}
```

---

## 8. パッケージ管理ツール

### npm/yarn

**基本的な操作**
```bash
# プロジェクト初期化
npm init -y

# パッケージインストール
npm install package-name
npm install -D dev-package-name  # 開発依存関係
npm install -g global-package    # グローバルインストール

# パッケージ削除
npm uninstall package-name

# 依存関係更新
npm update

# セキュリティ監査
npm audit
npm audit fix

# スクリプト実行
npm run script-name

# パッケージ情報表示
npm list
npm list -g  # グローバルパッケージ

# キャッシュクリア
npm cache clean --force
```

**package.json設定例**
```json
{
  "name": "my-project",
  "version": "1.0.0",
  "description": "My awesome project",
  "main": "index.js",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "eslint . --ext .ts,.tsx,.js,.jsx",
    "lint:fix": "eslint . --ext .ts,.tsx,.js,.jsx --fix",
    "type-check": "tsc --noEmit",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage"
  },
  "dependencies": {
    "next": "^14.0.0",
    "react": "^18.0.0",
    "react-dom": "^18.0.0"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "@types/react": "^18.0.0",
    "@types/react-dom": "^18.0.0",
    "eslint": "^8.0.0",
    "eslint-config-next": "^14.0.0",
    "typescript": "^5.0.0"
  }
}
```

---

## トラブルシューティング

### よくある問題と解決方法

**Node.jsバージョン管理**
```bash
# nvmを使ったバージョン切り替え
nvm install 18.17.0
nvm use 18.17.0
nvm alias default 18.17.0
```

**ポート競合エラー**
```bash
# ポートを使用しているプロセスを確認
lsof -i :3000
kill -9 PID

# 別のポートを使用
PORT=3001 npm run dev
```

**権限エラー（Linux/macOS）**
```bash
# npmグローバルパッケージの権限問題
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile
source ~/.profile
```

**Dockerコンテナ内でのファイル権限問題**
```dockerfile
# Dockerfileでユーザー作成
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
USER nextjs
```

このガイドを参考に、各ツールを効果的に活用してください。