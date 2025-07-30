# ===============================
# 🚀 AI開発環境用 .zshrc
# ===============================
# このファイルは社内共有用です。個人設定は適宜カスタマイズしてください。

# ===============================
# 🚀 Dev Container 検知 (最優先)
# ===============================
if grep -qE '/devcontainer|remote-containers' /proc/1/cgroup 2>/dev/null; then
  return
fi

# ===============================
# ⚡ Powerlevel10k instant prompt
# ===============================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===============================
# 🌟 Oh My Zsh Settings
# ===============================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"  # または "agnoster", "robbyrussell"
plugins=(
  git
  z
  web-search
  python
  zsh-syntax-highlighting
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

# ===============================
# ⚙️ User Preferences & AI開発用エイリアス
# ===============================
# エディタ設定
alias vi="nvim"
alias vim="nvim" 
alias view="nvim -R"
alias zshconfig="vim ~/.zshrc"

# AI開発用ショートカット
alias cl="claude"
alias clc="claude --continue"
alias clr="claude --resume"
alias gm="gemini"

# よく使うコマンド
alias ll="ls -la"
alias la="ls -A"
alias l="ls -CF"
alias ..="cd .."
alias ...="cd ../.."

# Git関連
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline"

# NPM/Node関連
alias ni="npm install"
alias ns="npm start"
alias nb="npm run build"
alias nd="npm run dev"

# Python関連
alias py="python3"
alias pip="pip3"

# ===============================
# 🔧 Shell Options
# ===============================
setopt no_beep
setopt hist_ignore_dups
setopt share_history
setopt inc_append_history
setopt auto_cd

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# ===============================
# 🎨 Powerlevel10k設定
# ===============================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ===============================
# 📦 Package Paths (macOS)
# ===============================
# Homebrew
if [[ -d "/opt/homebrew" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

# 開発用パッケージ
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include" 
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

# ===============================
# 🐍 Python環境 (pyenv)
# ===============================
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT" ]]; then
  export PATH="$PYENV_ROOT/shims:$PATH:$PYENV_ROOT/bin"
  eval "$(pyenv init -)"
fi

# ===============================
# ☕ Java (適宜調整)
# ===============================
# Java 11 (OpenJDK)
if [[ -d "/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home" ]]; then
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home"
  export PATH="$JAVA_HOME/bin:$PATH"
fi

# ===============================
# 🧪 Conda初期化 (存在する場合のみ)
# ===============================
# >>> conda initialize >>>
# 注意: ユーザー名を実際の値に置き換えてください
CONDA_PATH="$HOME/anaconda3"
if [[ -f "$CONDA_PATH/bin/conda" ]]; then
  __conda_setup="$('$CONDA_PATH/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  elif [ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]; then
    . "$CONDA_PATH/etc/profile.d/conda.sh"
  else
    export PATH="$CONDA_PATH/bin:$PATH"
  fi
  unset __conda_setup
fi
# <<< conda initialize <<<

# ===============================
# 📱 Node.js (NVM)
# ===============================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ===============================
# 🏠 個人用追加設定 (オプション)
# ===============================
# ~/.zshrc.local が存在すれば読み込み
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# ローカルbinパス
export PATH="$HOME/.local/bin:$PATH"

# AI開発用の環境変数設定例（必要に応じて）
# export OPENAI_API_KEY="your-key-here"
# export ANTHROPIC_API_KEY="your-key-here"