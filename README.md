# nvim

一个现代化、简洁高效的Neovim配置，专注于核心编辑体验，使用lazy.nvim进行插件管理。

## ✨ 特性

- **轻量快速**：精心挑选的核心插件，启动迅速
- **智能补全**：基于LSP的代码补全系统
- **语法增强**：Treesitter提供精准的语法高亮
- **高效导航**：FzfLua提供模糊查找和搜索
- **编辑增强**：自动配对、光标高亮等实用功能

## 📋 系统要求

- Neovim 0.10.0 或更高版本
- Git
- 支持真彩色的终端

## 🚀 安装

### Windows

```powershell
# 使用 PowerShell
cd $env:LOCALAPPDATA
git clone https://github.com/yuekcc/vimrc.nvim.git nvim
```

**GUI推荐：**
- [Neovide](https://github.com/neovide/neovide) - 跨平台GUI，配置中已优化

### Linux/macOS

```bash
cd ~/.config
git clone https://github.com/yuekcc/vimrc.nvim.git nvim
```

### 安装后

启动Neovim，插件会自动安装。首次启动可能需要等待插件安装和解析器编译。

## ⚙️ 配置概览

### 基本设置
- **Leader键**: 空格键 (`<Space>`)
- **系统剪贴板**: 启用 (`unnamedplus`)
- **持久化撤销**: 启用 (1000步历史)
- **交换文件**: 禁用
- **真彩色**: 启用

### UI设置
- **主题**: VSCode风格 (暗色/亮色自适应)
- **行号**: 显示绝对行号
- **光标**: 高亮当前行，平滑滚动
- **搜索**: 实时高亮，智能大小写
- **不可见字符**: 可视化显示

### 编辑器设置
- **缩进**: 4个空格，智能缩进
- **制表符**: 转换为空格
- **折行**: 禁用自动折行

## ⌨️ 键位映射

### 基础操作
| 键位 | 功能 | 模式 |
|------|------|------|
| `<leader>w` | 保存文件 | Normal |
| `<leader>q` | 退出 | Normal |
| `<esc>` | 清除搜索高亮 | Normal |

### 插入模式增强
| 键位 | 功能 |
|------|------|
| `Ctrl+a` | 移动到行首 |
| `Ctrl+e` | 移动到行尾 |
| `Ctrl+d` | 删除字符 |
| `Alt+h/j/k/l` | 光标移动(左/下/上/右) |
| `Shift+Enter` | 在下方新建行 |
| `Shift+Tab` | 减少缩进|

### Visual模式缩进调整
| 键位 | 功能 | 说明 |
|------|------|------|
| `Tab` | 增加缩进 | 选中文本块后向右缩进 |
| `Shift+Tab` | 减少缩进 | 选中文本块后向左缩进 |

### 窗口管理
| 键位 | 功能 |
|------|------|
| `Ctrl+\` | 垂直分割窗口 |
| `Ctrl+Shift+\` | 水平分割窗口 |
| `Ctrl+h/j/k/l` | 切换到对应窗口 |

### 文件查找 (FzfLua)
| 键位 | 功能 | 描述 |
|------|------|------|
| `<leader>ff` | 查找文件 | (f)ind (f)ile |
| `<leader>fs` | 实时搜索 | (f)ind (s)tring |
| `<leader>fw` | 查找当前词 | (f)ind (w)ord |

## 📦 插件配置

### 主题
- **插件**: [Mofiqul/vscode.nvim](https://github.com/Mofiqul/vscode.nvim)
- **特性**: 暗色主题，Neovide下自动切换亮色

### 代码补全
- **插件**: [saghen/blink.cmp](https://github.com/saghen/blink.cmp)
- **特性**: 
  - 支持LSP、路径、代码片段、缓冲区、Ripgrep
  - Super-Tab键位预设
  - 模糊匹配优化

### 语法解析
- **插件**: [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **支持语言**: bash, c, javascript, json, lua, markdown, python, typescript, yaml等20+语言
- **特性**: 自动安装和启用

### 模糊查找
- **插件**: [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua)
- **依赖**: fzf (需单独安装)
- **特性**: 文件、文本、单词快速搜索

### 编辑增强
- **自动配对**: [nvim-mini/mini.pairs](https://github.com/echasnovski/mini.nvim)
  - 支持括号、引号自动配对
  - 智能跳过规则
- **光标高亮**: [nvim-mini/mini.cursorword](https://github.com/echasnovski/mini.nvim)
  - 高亮光标下的单词

## 🎨 字体配置

**推荐字体**: Maple Mono Normal NF CN (Nerd Font版本)

```vim
vim.opt.guifont = 'Maple Mono Normal NL NF CN:h13'
```

## 🔧 自定义配置

### 添加新插件

在`init.lua`的`require("lazy").setup()`中添加：

```lua
{
    "插件作者/插件名",
    config = function()
        -- 配置代码
    end
}
```

### 修改键位映射

在`init.lua`中添加：

```lua
vim.keymap.set('模式', '键位', '命令', { desc = '描述' })
```

### 添加Treesitter语言

在`ensure_installed`列表中添加语言名称：

```lua
ensure_installed = {
    "bash",
    "python",
    -- 添加其他语言...
}
```

## 🆘 常见问题

### 插件未安装
首次启动可能需要等待，或手动运行：
```vim
:Lazy install
```

### Treesitter解析器未安装
手动安装特定语言解析器：
```vim
:TSInstall 语言名
```

### 补全不工作
确保已安装对应语言的LSP服务器，例如：
- Python: `pip install pyright`
- JavaScript/TypeScript: `npm install -g typescript-language-server`

## 📄 许可证

MIT License - 详见 LICENSE 文件

## 🗺️ 项目结构

```
nvim/
├── init.lua              # 主配置文件
├── lazy-lock.json        # 插件锁定文件
└── README.md             # 本文档
```

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 🔗 相关链接

- [Neovim官网](https://neovim.io/)
- [lazy.nvim文档](https://github.com/folke/lazy.nvim)
- [Treesitter文档](https://github.com/nvim-treesitter/nvim-treesitter)