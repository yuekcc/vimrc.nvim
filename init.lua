-- 基本设置
vim.opt.mouse = 'a'                    -- 启用鼠标支持
vim.opt.updatetime = 200               -- 写入交换文件的间隔时间（毫秒）
vim.opt.timeoutlen = 500               -- 映射键序列的等待时间
vim.opt.confirm = true                 -- 未保存时退出需要确认
vim.opt.termguicolors = true           -- 启用真彩色支持

-- 全局变量设置
vim.g.editorconfig = true              -- 启用 EditorConfig 支持
vim.g.markdown_recommended_style = 0   -- 修复 markdown 缩进设置

-- [[ UI 设置]]
vim.opt.number = true                  -- 显示行号
vim.opt.showmode = true                -- 显示当前模式
vim.opt.list = true                    -- 显示不可见字符
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- 不可见字符的显示方式
vim.opt.inccommand = 'split'           -- 实时显示替换效果
vim.opt.cursorline = true              -- 高亮当前行
vim.opt.foldenable = false             -- 禁用代码折叠
vim.opt.foldnestmax = 1                -- 最大折叠层级
vim.opt.cmdheight = 0                  -- 命令栏高度（0 为自动调整）
vim.opt.winminwidth = 5                -- 窗口最小宽度
vim.opt.wildmode = "longest:full,full" -- 命令行补全模式
vim.opt.list = true                    -- 显示不可见字符（重复设置）
vim.opt.scrolloff = 4                  -- 上下滚动时保留的行数
vim.opt.smoothscroll = true            -- 启用平滑滚动

-- 字体设置（仅 GUI 版本有效）
vim.opt.guifont = 'Maple Mono Normal NL NF CN:h13'

-- [[ 搜索设置 ]]
vim.opt.ignorecase = true              -- 搜索时忽略大小写
vim.opt.smartcase = true               -- 如果有大写字母则区分大小写
vim.opt.hlsearch = true                -- 高亮搜索结果
vim.opt.incsearch = true               -- 实时搜索

-- [[ 编辑设置 ]]
vim.opt.swapfile = false               -- 不创建交换文件
vim.opt.undofile = true                -- 持久化撤销历史
vim.opt.undolevels = 1000              -- 撤销步数限制

-- 异步设置剪贴板（避免启动时冲突）
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'  -- 使用系统剪贴板
end)

vim.opt.breakindent = true             -- 折行时保持缩进

-- 缩进设置
vim.opt.expandtab = true               -- 将 Tab 转换为空格
vim.opt.tabstop = 4                    -- Tab 显示为 4 个空格宽度
vim.opt.shiftround = true              -- 缩进对齐到 shiftwidth 的倍数
vim.opt.shiftwidth = 4                 -- 自动缩进使用的空格数
vim.opt.softtabstop = 4                -- 编辑时 Tab 键的行为
vim.opt.smartindent = true             -- 智能缩进

vim.opt.wrap = false                   -- 不自动折行

-- [[ 键位映射 ]]

-- 设置 Leader 键
vim.g.mapleader = ' '                  -- 全局 Leader 键为空格
vim.g.maplocalleader = ' '             -- 本地 Leader 键为空格

-- 清除搜索高亮
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')

-- 保存和退出
vim.keymap.set('n', '<leader>w', ':w<cr>')  -- 保存文件
vim.keymap.set('n', '<leader>q', ':q<cr>')  -- 退出

-- 插入模式下的移动和编辑
vim.keymap.set('i', '<C-a>', '<home>')      -- 移动到行首
vim.keymap.set('i', '<C-e>', '<end>')       -- 移动到行尾
vim.keymap.set('i', '<C-d>', '<del>')       -- 删除光标后字符

-- Alt 键移动（兼容性映射）
vim.keymap.set('i', '<m-k>', '<up>')        -- 上移
vim.keymap.set('i', '<m-j>', '<down>')      -- 下移
vim.keymap.set('i', '<m-h>', '<left>')      -- 左移
vim.keymap.set('i', '<m-l>', '<right>')     -- 右移

-- 快速换行
vim.keymap.set('i', '<S-cr>', '<esc>o')     -- Shift+Enter 在下方新建行

-- Visual模式缩进调整
vim.keymap.set('v', '<tab>', '>gv')         -- 增加缩进
vim.keymap.set('v', '<S-tab>', '<gv')       -- 减少缩进

-- Insert模式缩进调整
vim.keymap.set('i', '<S-tab>', '<C-d>')     -- Shift+Tab 减少缩进 (保留Tab用于补全)

-- 窗口管理
vim.keymap.set('n', '<C-\\>', '<cmd>vsplit<cr>')    -- 垂直分割窗口
vim.keymap.set('n', '<C-S-\\>', '<cmd>split<cr>')   -- 水平分割窗口
vim.keymap.set('n', '<C-h>', '<C-w>h')              -- 切换到左侧窗口
vim.keymap.set('n', '<C-j>', '<C-w>j')              -- 切换到下方窗口
vim.keymap.set('n', '<C-k>', '<C-w>k')              -- 切换到上方窗口
vim.keymap.set('n', '<C-l>', '<C-w>l')              -- 切换到右侧窗口

-- [[ 插件管理 ]]

-- 引导 lazy.nvim 插件管理器
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)          -- 将 lazy.nvim 添加到运行时路径

-- 设置插件
require("lazy").setup({
    -- 主题
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd[[colorscheme tokyonight]]
        end
    },
    -- 光标下单词高亮
    {
        "nvim-mini/mini.cursorword",
        version = '*',
        lazy = false,
        config = function(_, opts)
            require('mini.cursorword').setup()
        end
    },
    -- 自动配对符号
    {
        "nvim-mini/mini.pairs",
        version = '*',
        event = "VeryLazy",             -- 延迟加载
        opts = {
            modes = { insert = true, command = true, terminal = false },
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],  -- 跳过这些字符后的配对
            skip_ts = { "string" },     -- 在字符串中跳过
            skip_unbalanced = true,     -- 跳过不平衡的符号
            markdown = true,            -- 在 markdown 中启用
        },
        config = function (_, opts)
            require('mini.pairs').setup()
        end
    },
    
    -- 代码补全引擎
    {
        'saghen/blink.cmp',
        version = '*',
        event = "InsertEnter",          -- 插入模式时加载
        dependencies = {
            'xzbdmw/colorful-menu.nvim',
            'mikavilpas/blink-ripgrep.nvim',  -- 依赖的 ripgrep 源
        },
        opts = {
            keymap = { 
                preset = 'super-tab',   -- 使用 super-tab 键位预设。super-tab/enter
            },
            appearance = {
                use_nvim_cmp_as_default = true,  -- 使用 nvim-cmp 样式
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep' },  -- 补全源
                providers = {
                    ripgrep = {         -- ripgrep 源配置
                        module = 'blink-ripgrep',
                        name = 'Ripgrep',
                    },
                },
            },
            fuzzy = { implementation = 'prefer_rust_with_warning' },  -- 模糊匹配实现
        }
    },
    
    -- 语法高亮和代码解析
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",            -- 安装命令
        lazy = false,                   -- 立即加载
        opts = {
            ensure_installed = {        -- 确保安装的语法解析器
                "bash",
                "c",
                "diff",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "printf",
                "python",
                "query",
                "regex",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml"
            }
        },
        config = function(_, opts)
            local nvim_treesitter = require "nvim-treesitter"
            nvim_treesitter.setup(opts)
            
            -- 安装缺失的 parser
            for _, parser in ipairs(opts.ensure_installed) do
                local has_parser, _ = pcall(vim.treesitter.language.inspect, parser)
                if not has_parser then
                    nvim_treesitter.install(parser)
                end
            end

            -- 自动为支持的文件类型启用 treesitter
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("my_treesitter", { clear = true }),
                callback = function(ev)
                    local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
                    if lang then
                        pcall(vim.treesitter.start, ev.buf)  -- 安全启用 treesitter
                    end
                end
            })
        end,
    },
    
    -- 模糊查找工具
    {
        'dmtrKovalenko/fff.nvim',
        build = function()
            require('fff.download').download_or_build_binary()
        end,
        lazy = false,
        keys = {
            { "<leader>ff", function() require('fff').find_files() end },
            { "<leader>fg", function() requrie('fff').live_grep() end },
            {
                "<leader>fz", 
                function()
                    require('fff').live_grep({
                        grep = {
                            modes = { 'fuzzy', 'plain' }
                        }
                    })
                end
            },
            {
                "<leader>fc",
                function()
                    require('fff').live_grep({ query = vim.fn.expand("<cword>") })
                end
            }
        }
    }
})

-- [[ 自动命令 ]]

-- 创建自动命令组函数
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- 检查文件外部更改并重新加载
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then   -- 如果不是特殊缓冲区
      vim.cmd("checktime")              -- 检查文件时间戳
    end
  end,
})

-- 高亮复制文本
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()  -- 短暂高亮复制的文本
  end,
})
