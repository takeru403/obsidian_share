#!/bin/bash
# ===============================
# AI開発環境セットアップスクリプト
# ===============================
# 使用方法: bash setup.sh

set -e  # エラー時に停止

# カラー定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ログ関数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# ===============================
# システム検知
# ===============================
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="Linux"
    else
        log_error "サポートされていないOS: $OSTYPE"
        exit 1
    fi
    log_info "検知されたOS: $OS"
}

# ===============================
# バックアップ作成
# ===============================
backup_existing_files() {
    log_info "既存のdotfilesをバックアップ中..."
    
    backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    files=(.zshrc .gitconfig .tmux.conf .vimrc)
    
    for file in "${files[@]}"; do
        if [[ -f "$HOME/$file" ]]; then
            cp "$HOME/$file" "$backup_dir/"
            log_info "バックアップ作成: $HOME/$file -> $backup_dir/$file"
        fi
    done
    
    log_success "バックアップ完了: $backup_dir"
}

# ===============================
# 必要ツールのインストール
# ===============================
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        log_info "Homebrewをインストール中..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Apple Siliconの場合のパス追加
        if [[ -d "/opt/homebrew" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        
        log_success "Homebrew インストール完了"
    else
        log_info "Homebrew は既にインストールされています"
    fi
}

install_basic_tools() {
    log_info "基本ツールをインストール中..."
    
    # 基本ツール
    tools=(git vim tmux zsh)
    
    if [[ "$OS" == "macOS" ]]; then
        for tool in "${tools[@]}"; do
            if ! brew list "$tool" &> /dev/null; then
                brew install "$tool"
            fi
        done
    fi
    
    log_success "基本ツール インストール完了"
}

install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Oh My Zshをインストール中..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "Oh My Zsh インストール完了"
    else
        log_info "Oh My Zsh は既にインストールされています"
    fi
}

install_zsh_plugins() {
    log_info "Zshプラグインをインストール中..."
    
    # zsh-syntax-highlighting
    if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    fi
    
    # zsh-autosuggestions
    if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    fi
    
    # powerlevel10k
    if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    fi
    
    log_success "Zshプラグイン インストール完了"
}

install_ai_tools() {
    log_info "AIツールをインストール中..."
    
    # Node.js (NVM経由)
    if [[ ! -d "$HOME/.nvm" ]]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        nvm install --lts
        nvm use --lts
    fi
    
    # Claude Code (手動インストールが必要な場合)
    if ! command -v claude &> /dev/null; then
        log_warning "Claude Codeは手動でインストールしてください"
        log_info "https://claude.ai/code からダウンロード"
    fi
    
    # Gemini CLI
    if ! command -v gemini &> /dev/null; then
        if command -v npm &> /dev/null; then
            npm install -g gemini-cli
            log_success "Gemini CLI インストール完了"
        else
            log_warning "npm が見つからないため、Gemini CLI をスキップ"
        fi
    fi
    
    # Python関連
    if [[ "$OS" == "macOS" ]]; then
        brew install python
        pip3 install --upgrade pip
    fi
}

# ===============================
# dotfiles適用
# ===============================
apply_dotfiles() {
    log_info "dotfilesを適用中..."
    
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    files=(.zshrc .gitconfig .tmux.conf .vimrc)
    
    for file in "${files[@]}"; do
        if [[ -f "$script_dir/$file" ]]; then
            cp "$script_dir/$file" "$HOME/"
            log_info "適用: $file"
        else
            log_warning "ファイルが見つかりません: $script_dir/$file"
        fi
    done
    
    # aliases.shをソース
    if [[ -f "$script_dir/aliases.sh" ]]; then
        if ! grep -q "source.*aliases.sh" "$HOME/.zshrc"; then
            echo "" >> "$HOME/.zshrc"
            echo "# AI開発用エイリアス" >> "$HOME/.zshrc"
            echo "source $script_dir/aliases.sh" >> "$HOME/.zshrc"
        fi
    fi
    
    log_success "dotfiles 適用完了"
}

# ===============================
# Git設定
# ===============================
setup_git() {
    log_info "Git設定を確認中..."
    
    if [[ $(git config --global user.name) == "Your Name" ]] || [[ -z $(git config --global user.name) ]]; then
        read -p "Git ユーザー名を入力: " git_name
        git config --global user.name "$git_name"
    fi
    
    if [[ $(git config --global user.email) == "your.email@company.com" ]] || [[ -z $(git config --global user.email) ]]; then
        read -p "Git メールアドレスを入力: " git_email
        git config --global user.email "$git_email"
    fi
    
    log_success "Git設定完了"
}

# ===============================
# メイン実行
# ===============================
main() {
    echo "================================="
    echo "  AI開発環境セットアップ開始"
    echo "================================="
    
    detect_os
    
    # 確認
    read -p "セットアップを続行しますか？ (y/N): " response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        log_info "セットアップをキャンセルしました"
        exit 0
    fi
    
    backup_existing_files
    
    if [[ "$OS" == "macOS" ]]; then
        install_homebrew
        install_basic_tools
    fi
    
    install_oh_my_zsh
    install_zsh_plugins
    install_ai_tools
    apply_dotfiles
    setup_git
    
    echo ""
    echo "================================="
    log_success "🎉 セットアップ完了！"
    echo "================================="
    echo ""
    echo "次のステップ:"
    echo "1. ターミナルを再起動してください"
    echo "2. Claude Code認証: claude auth"
    echo "3. Gemini CLI設定: gemini config set api-key YOUR_API_KEY"
    echo "4. 新しいプロジェクト作成: new_project my-app"
    echo ""
    echo "詳細な使用方法: README.md を確認してください"
}

# スクリプト実行
main "$@"