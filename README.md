# AI活用Webアプリ開発ガイド

> プログラミング未経験者でも要件を伝えるだけでWebアプリケーションを開発できる技術資料集

## 📋 概要

このプロジェクトは、社内でAIツールを活用してプログラミング知識がない人でも、要件を伝えるだけで自分でWebアプリケーションを作成するための技術資料をまとめたものです。

## 🎯 対象者

- プログラミング未経験だがWebアプリを作りたい社員
- AIツールを活用した開発手法を学びたい方
- 業務効率化のためのアプリケーション開発を検討している方

## 🛠 主要技術スタック

### フロントエンド
- **Next.js** - React基盤のフルスタックフレームワーク
- **React** - UI構築ライブラリ
- **Tailwind CSS** - ユーティリティファーストCSSフレームワーク

### バックエンド
- **FastAPI** (Python) - 軽量・高速なAPIフレームワーク
- **Node.js** - Next.jsのサーバーサイド処理

### AIツール
- **Claude Code** - AIによるコーディング支援（月額20ドル）
- **Gemini CLI** - 無料のコマンドラインAIツール
- **bolt.new** - AIによるUI生成ツール

## 📁 プロジェクト構成

```
share/
├── README.md                    # このファイル
├── CLAUDE.md                    # プロジェクト設定・技術スタック詳細
├── 導入ツール.md                # 使用ツールの概要
├── 各ツール使用方法/            # 各AIツールの使用方法
│   ├── claude_code使い方/
│   └── geminicli_使用方法/
└── POS分析アプリ/              # 実例：POSデータ可視化アプリ
    └── POSデータ可視化アプリ.md
```

## 🚀 クイックスタート

### 1. 必要ツールのインストール

**基本ツール**
```bash
# Homebrew（macOS）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Claude Code
curl -L https://github.com/anthropics/claude-code/releases/latest/download/claude-code-macos.zip -o claude-code.zip

# Gemini CLI
npm install -g gemini-cli
```

**開発環境**
```bash
# Node.js & npm
brew install node

# Python & Poetry
brew install python poetry

# Git & GitHub CLI
brew install git gh

# ターミナル拡張
brew install --cask iterm2
brew install tmux
```

### 2. 開発フローの基本

1. **UI設計** - bolt.newでアプリの見た目を生成
2. **コード管理** - GitHubでバージョン管理
3. **バックエンド開発** - Claude Codeで裏側の処理を実装
4. **デプロイ** - Vercel等でWebアプリを公開

## 📖 学習リソース

### ステップバイステップガイド
- [POS分析アプリ開発例](./POS分析アプリ/POSデータ可視化アプリ.md) - 実際のアプリ開発手順

### ツール使用方法
- [Claude Code基本操作](./各ツール使用方法/claude_code使い方/基本)
- [Gemini CLI基本操作](./各ツール使用方法/geminicli_使用方法/基本)

### 技術詳細
- [CLAUDE.md](./CLAUDE.md) - 詳細な技術スタック情報
- [導入ツール.md](./導入ツール.md) - 各ツールの概要と特徴

## 💡 開発のコツ

### AI活用のベストプラクティス
1. **具体的な要件定義** - 作りたい機能を詳細に文章で表現
2. **段階的開発** - UI → バックエンド → テスト → デプロイの順序
3. **ツールの使い分け** - UI生成はbolt.new、コード実装はClaude Code

### よくある課題と解決策
- **エラー対処** - Claude CodeがCLIでエラーを自動読み取り・修正
- **コード理解** - Gemini CLIで無料相談
- **バージョン管理** - GitHub + GitHub CLIで自動化

## 🔗 関連リンク

- [bolt.new](https://bolt.new) - AI UI生成ツール
- [Claude Code](https://claude.ai/code) - AI開発支援ツール
- [GitHub](https://github.com) - コード管理プラットフォーム
- [Vercel](https://vercel.com) - Next.js最適化ホスティング

## 📞 サポート

社内での技術的な質問や導入支援については、開発チームまでお気軽にご相談ください。

---

*最終更新: 2025年7月*
