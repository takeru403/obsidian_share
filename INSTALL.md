# 開発環境セットアップガイド

このドキュメントでは、プロジェクトで使用する技術スタックのインストール方法について説明します。

## 前提条件

以下のツールが必要です：
- Git
- インターネット接続
- 管理者権限（一部のインストールで必要）

## 1. フロントエンド関連

### Node.js（必須）

**macOS（Homebrew使用）**
```bash
# Homebrewがインストールされていない場合
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Node.jsをインストール
brew install node

# バージョン確認
node --version
npm --version
```

**Windows**
1. [Node.js公式サイト](https://nodejs.org/)からLTS版をダウンロード
2. ダウンロードしたインストーラーを実行
3. インストール完了後、コマンドプロンプトで確認：
```cmd
node --version
npm --version
```

**Linux（Ubuntu/Debian）**
```bash
# Node.jsリポジトリを追加
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# Node.jsをインストール
sudo apt-get install -y nodejs

# バージョン確認
node --version
npm --version
```

### Next.js・React・TypeScript

**新規プロジェクト作成**
```bash
npx create-next-app@latest my-app --typescript --tailwind --eslint --app
cd my-app
```

**既存プロジェクトに追加**
```bash
npm install next react react-dom typescript @types/react @types/node
```

### Tailwind CSS

**Next.jsプロジェクトに追加**
```bash
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

## 2. バックエンド関連

### Python（FastAPI用）

**macOS**
```bash
# Homebrewでインストール
brew install python

# バージョン確認
python3 --version
pip3 --version
```

**Windows**
1. [Python公式サイト](https://www.python.org/downloads/)から最新版をダウンロード
2. インストール時に「Add Python to PATH」にチェック
3. インストール完了後、コマンドプロンプトで確認：
```cmd
python --version
pip --version
```

**Linux（Ubuntu/Debian）**
```bash
sudo apt update
sudo apt install python3 python3-pip python3-venv

# バージョン確認
python3 --version
pip3 --version
```

### Poetry（Python依存関係管理）

**全プラットフォーム共通**
```bash
# Poetryをインストール
curl -sSL https://install.python-poetry.org | python3 -

# パスを通す（~/.bashrc または ~/.zshrc に追加）
export PATH="$HOME/.local/bin:$PATH"

# ターミナルを再起動またはソース読み込み
source ~/.bashrc  # または source ~/.zshrc

# バージョン確認
poetry --version
```

### FastAPI

**Poetryを使用**
```bash
# 新しいプロジェクト作成
poetry new fastapi-project
cd fastapi-project

# FastAPIとUvicornを追加
poetry add fastapi uvicorn[standard]

# 開発依存関係を追加
poetry add --group dev pytest black flake8
```

**pipを使用**
```bash
# 仮想環境作成（推奨）
python3 -m venv venv
source venv/bin/activate  # Linux/macOS
# venv\Scripts\activate  # Windows

# FastAPIをインストール
pip install fastapi uvicorn[standard]
```

## 3. データベース関連

### PostgreSQL

**macOS**
```bash
# PostgreSQLをインストール
brew install postgresql

# サービス開始
brew services start postgresql

# データベース作成（初回のみ）
createdb mydatabase

# 接続確認
psql mydatabase
```

**Windows**
1. [PostgreSQL公式サイト](https://www.postgresql.org/download/windows/)からインストーラーをダウンロード
2. インストーラーを実行し、セットアップウィザードに従う
3. pgAdminもインストールされます

**Linux（Ubuntu/Debian）**
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib

# PostgreSQLサービス開始・有効化
sudo systemctl start postgresql
sudo systemctl enable postgresql

# PostgreSQLユーザーでログイン
sudo -u postgres psql

# 新しいデータベースとユーザー作成
CREATE DATABASE mydatabase;
CREATE USER myuser WITH PASSWORD 'mypassword';
GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;
\q
```

### SQLite

**インストール確認**
```bash
sqlite3 --version
```

**macOS（必要に応じて）**
```bash
brew install sqlite
```

**Linux（必要に応じて）**
```bash
sudo apt install sqlite3
```

## 4. 開発ツール・環境

### Claude Code（AI支援ツール）

1. [Claude Code公式サイト](https://claude.ai/code)にアクセス
2. アカウント作成またはログイン
3. サブスクリプション契約（月額20ドル）
4. CLIツールのインストール指示に従う

### Gemini CLI（無料）

**Node.js経由**
```bash
npm install -g @google/generative-ai-cli

# 認証設定
gemini auth login
```

**Python経由**
```bash
# pipxがない場合はインストール
pip install pipx

# Gemini CLIをインストール
pipx install google-generativeai

# バージョン確認
gemini --version
```

### iTerm2（macOSのみ）

1. [iTerm2公式サイト](https://iterm2.com/)からダウンロード
2. ダウンロードしたzipファイルを解凍
3. iTerm.appをApplicationsフォルダに移動

### tmux（ターミナルマルチプレクサ）

**macOS**
```bash
brew install tmux

# 基本的な使い方
tmux new-session -s mysession  # 新しいセッション作成
tmux attach -t mysession       # セッションに接続
# Ctrl+b, d でデタッチ
```

**Linux**
```bash
sudo apt install tmux

# 設定ファイル作成（オプション）
touch ~/.tmux.conf
```

### Zsh

**macOS**
```bash
# Zshは標準搭載、確認方法
echo $SHELL

# Oh My Zshをインストール（オプション）
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**Linux**
```bash
# Zshをインストール
sudo apt install zsh

# デフォルトシェルに設定
chsh -s $(which zsh)

# Oh My Zshをインストール（オプション）
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### GitHub CLI

**macOS**
```bash
brew install gh

# 認証
gh auth login
```

**Windows**
```bash
winget install --id GitHub.cli

# または Chocolateyを使用
choco install gh

# 認証
gh auth login
```

**Linux**
```bash
# GitHub CLIリポジトリを追加
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# インストール
sudo apt update
sudo apt install gh

# 認証
gh auth login
```

## 5. インフラ・デプロイメントツール

### Docker

**macOS**
```bash
# Docker Desktopをインストール
brew install --cask docker

# または公式サイトからDocker Desktopをダウンロード
# https://docs.docker.com/desktop/install/mac-install/

# Docker Desktopを起動後、確認
docker --version
docker-compose --version
```

**Windows**
1. [Docker Desktop公式サイト](https://docs.docker.com/desktop/install/windows-install/)からダウンロード
2. インストーラーを実行
3. WSL 2が必要な場合は指示に従ってインストール
4. Docker Desktopを起動

**Linux（Ubuntu）**
```bash
# 古いバージョンを削除
sudo apt-get remove docker docker-engine docker.io containerd runc

# 必要なパッケージをインストール
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release

# DockerのGPGキーを追加
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# リポジトリを追加
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Dockerをインストール
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# ユーザーをdockerグループに追加
sudo usermod -aG docker $USER

# サービス開始・有効化
sudo systemctl start docker
sudo systemctl enable docker

# 再ログインまたは以下のコマンドでグループ変更を適用
newgrp docker

# 確認
docker --version
```

### Terraform

**macOS**
```bash
# HashiCorpタップを追加
brew tap hashicorp/tap

# Terraformをインストール
brew install hashicorp/tap/terraform

# バージョン確認
terraform --version
```

**Windows**
```bash
# Chocolateyを使用
choco install terraform

# または手動インストール
# 1. https://www.terraform.io/downloads から最新版をダウンロード
# 2. zipファイルを解凍
# 3. terraform.exeをPATHが通ったディレクトリに配置
```

**Linux**
```bash
# HashiCorpのGPGキーを追加
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

# リポジトリを追加
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# インストール
sudo apt update && sudo apt install terraform

# バージョン確認
terraform --version
```

### AWS CLI（Terraform使用時に必要）

**macOS**
```bash
brew install awscli

# 設定
aws configure
```

**Windows**
1. [AWS CLI公式サイト](https://aws.amazon.com/cli/)からインストーラーをダウンロード
2. インストーラーを実行
3. コマンドプロンプトで設定：
```cmd
aws configure
```

**Linux**
```bash
# AWS CLI v2をダウンロード・インストール
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# 設定
aws configure

# バージョン確認
aws --version
```

### Vercel CLI（Next.jsデプロイ用）

**全プラットフォーム共通**
```bash
# グローバルインストール
npm install -g vercel

# ログイン
vercel login

# プロジェクトをデプロイ（プロジェクトディレクトリで実行）
vercel
```

## 6. 追加の重要な設定

### Git設定（初回のみ）

```bash
# ユーザー名とメールアドレスを設定
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# デフォルトブランチ名を設定
git config --global init.defaultBranch main

# エディタを設定（例：VSCode）
git config --global core.editor "code --wait"

# 設定確認
git config --list
```

### SSH鍵の設定（GitHub用）

```bash
# SSH鍵を生成
ssh-keygen -t ed25519 -C "your.email@example.com"

# ssh-agentを開始
eval "$(ssh-agent -s)"

# SSH鍵をssh-agentに追加
ssh-add ~/.ssh/id_ed25519

# 公開鍵をクリップボードにコピー
# macOS
pbcopy < ~/.ssh/id_ed25519.pub

# Linux
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard

# Windows (Git Bash)
cat ~/.ssh/id_ed25519.pub | clip

# GitHubの設定に公開鍵を追加
# 1. GitHub.com > Settings > SSH and GPG keys
# 2. "New SSH key" をクリック
# 3. 公開鍵を貼り付け

# 接続テスト
ssh -T git@github.com
```

### 環境変数の設定

**~/.bashrc または ~/.zshrc に追加**
```bash
# Node.js関連
export NODE_ENV=development

# Python関連
export PYTHONPATH="${PYTHONPATH}:${PWD}"

# AWS関連（必要に応じて）
export AWS_REGION=ap-northeast-1

# パスを通す
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"  # Apple Silicon Mac

# 設定を反映
source ~/.bashrc  # または source ~/.zshrc
```

## トラブルシューティング

### よくある問題と解決方法

**Node.jsのバージョン管理**
```bash
# nvmをインストール（Node Version Manager）
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# 最新のLTSをインストール
nvm install --lts
nvm use --lts
```

**Pythonの仮想環境**
```bash
# 仮想環境を作成
python3 -m venv myproject
source myproject/bin/activate  # Linux/macOS
# myproject\Scripts\activate    # Windows

# 仮想環境を終了
deactivate
```

**パーミッション問題（Linux/macOS）**
```bash
# npmのグローバルパッケージでパーミッションエラーが発生する場合
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile
source ~/.profile
```

## 次のステップ

1. 各ツールが正常にインストールされているか確認
2. サンプルプロジェクトを作成してテスト
3. IDE（VSCode等）の設定
4. 各サービスのアカウント作成・認証設定

このガイドに従って環境をセットアップすれば、プロジェクトの開発を開始できます。