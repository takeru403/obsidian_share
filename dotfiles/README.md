# 🛠️ AI開発環境用 Dotfiles

> 社内でAI活用開発を行うための統一された開発環境設定

## 📋 概要

このdotfilesセットは、Claude CodeやGemini CLIなどのAIツールを活用した開発に最適化された設定ファイル群です。新しいチームメンバーが迅速に開発環境を構築し、統一された設定で作業を開始できます。

## 📁 含まれるファイル

```
dotfiles/
├── .zshrc           # Zsh設定（AI開発用エイリアス付き）
├── .gitconfig       # Git設定（汎用化済み）
├── .tmux.conf       # Tmux設定（AI開発に最適化）
├── .vimrc           # Vim設定（基本的な開発用設定）
├── aliases.sh       # AI開発用エイリアス・関数集
├── setup.sh         # 自動セットアップスクリプト
└── README.md        # このファイル
```

## 🚀 クイックセットアップ

### 自動セットアップ（推奨）

```bash
# リポジトリをクローン
git clone <your-repo-url>
cd share/dotfiles

# 自動セットアップスクリプトを実行
bash setup.sh
```

### 手動セットアップ

```bash
# 既存ファイルのバックアップ
cp ~/.zshrc ~/.zshrc.backup 2>/dev/null || true
cp ~/.gitconfig ~/.gitconfig.backup 2>/dev/null || true

# dotfilesをコピー
cp .zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig
cp .tmux.conf ~/.tmux.conf
cp .vimrc ~/.vimrc

# エイリアスを.zshrcに追加
echo "source $(pwd)/aliases.sh" >> ~/.zshrc

# ターミナルを再起動
exec zsh
```

## ⚙️ 個人設定のカスタマイズ

### 必須設定

**Git設定**
```bash
# .gitconfigの[user]セクションを編集
git config --global user.name "Your Name"
git config --global user.email "your.email@company.com"
```

**APIキー設定**
```bash
# Claude Code認証
claude auth

# Gemini CLI設定
gemini config set api-key "your-gemini-api-key"
```

### オプション設定

**個人用設定ファイル**
```bash
# 個人用の追加設定は ~/.zshrc.local に記述
touch ~/.zshrc.local
echo "# 個人用設定" >> ~/.zshrc.local
```

## 🎯 主要機能

### AI開発用エイリアス

```bash
# AIツール起動
cl                   # claude
clc                  # claude --continue
clr                  # claude --resume
gm                   # gemini

# 開発ワークフロー
new_project my-app   # 新プロジェクト作成＋Claude起動
gemini_files *.js    # 複数ファイルをGeminiに送信
project_stats        # プロジェクト統計表示
```

### Git効率化

```bash
gs                   # git status
ga                   # git add
gcm "message"        # git commit -m
gp                   # git push
gl                   # git log --oneline
```

### 開発環境

```bash
ni                   # npm install
nd                   # npm run dev
nb                   # npm run build
py                   # python3
serve                # HTTPサーバー起動（8000番ポート）
```

## 🔧 Tmux設定

### キーバインド

| コマンド | 機能 |
|---------|------|
| `Ctrl-g` | プレフィックスキー |
| `Ctrl-g + \|` | 縦分割 |
| `Ctrl-g + -` | 横分割 |
| `Ctrl-g + h/j/k/l` | ペイン移動 |
| `Ctrl-g + c` | 新ウィンドウ（Claude自動起動） |
| `Ctrl-g + g` | Gemini用ウィンドウ作成 |
| `Ctrl-g + r` | 設定リロード |

## 📊 便利な関数

### プロジェクト作成

```bash
new_project my-awesome-app
# → ディレクトリ作成、Git初期化、README生成、Claude起動オプション
```

### 複数ファイル分析

```bash
gemini_files src/components/*.tsx
# → 指定したファイル群をGeminiで一括分析
```

### プロジェクト統計

```bash
project_stats
# → ファイル数、行数、コミット数などを表示
```

## 🎨 Zsh設定の特徴

- **Powerlevel10k テーマ**: 美しく情報豊富なプロンプト
- **シンタックスハイライト**: コマンドの色分け表示
- **オートサジェスト**: 履歴ベースの入力補完
- **履歴共有**: 複数ターミナル間での履歴同期
- **AI開発最適化**: Claude、Geminiへの素早いアクセス

## 🔍 トラブルシューティング

### Oh My Zshが見つからない

```bash
# Oh My Zshを手動インストール
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Powerlevel10kテーマエラー

```bash
# テーマを手動インストール
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### エイリアスが効かない

```bash
# .zshrcを再読み込み
source ~/.zshrc

# または新しいターミナルセッションを開始
exec zsh
```

### Git設定が反映されない

```bash
# 現在の設定を確認
git config --global --list

# 設定を再適用
git config --global user.name "Your Name"
git config --global user.email "your.email@company.com"
```

## 🔄 更新・同期

### dotfilesの更新

```bash
# リポジトリから最新版を取得
cd path/to/dotfiles
git pull origin main

# セットアップスクリプトを再実行
bash setup.sh
```

### 個人設定のバックアップ

```bash
# 現在の設定をバックアップ
tar czf my-dotfiles-backup-$(date +%Y%m%d).tar.gz ~/.zshrc ~/.gitconfig ~/.tmux.conf ~/.vimrc
```

## 📚 参考資料

### AI開発ツール
- [Claude Code公式ドキュメント](https://docs.anthropic.com/claude/docs)
- [Gemini API ドキュメント](https://ai.google.dev/docs)

### 開発環境
- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Tmux](https://github.com/tmux/tmux)

## 🤝 貢献・フィードバック

設定の改善提案や問題報告は、チーム内のSlackチャンネルまたはGitHub Issuesでお知らせください。

---

*最終更新: 2025年7月*