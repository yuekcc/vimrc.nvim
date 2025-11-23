vim.opt.mouse = 'a'
vim.opt.updatetime = 200
vim.opt.timeoutlen = 500
vim.opt.confirm = true
vim.opt.termguicolors = true

vim.g.editorconfig = true
vim.g.markdown_recommended_style = 0 -- fix markdown indentation settings

vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
    c3t = "c3",
  },
})

-- [[ UI 设置]]

vim.opt.number = true
vim.opt.showmode = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.foldenable = false
vim.opt.foldnestmax = 1
vim.opt.cmdheight = 0
vim.opt.winminwidth = 5
vim.opt.wildmode = "longest:full,full"
vim.opt.list = true
vim.opt.scrolloff = 4
vim.opt.smoothscroll = true

vim.opt.guifont = 'Maple Mono Normal NL NF CN:h13'

-- [[ 搜索设置 ]]
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- [[ 编辑设置 ]]

vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 1000

vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.smartcase = true

vim.opt.wrap = false -- 自动折行

-- [[ 自动重新加载 ]]
-- copy from LazyVim
--local group = vim.api.nvim_create_augroup("LazyVim", { clear = true })
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- [[ keymaps ]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')

vim.keymap.set('n', '<leader>w', ':w<cr>')
vim.keymap.set('n', '<leader>q', ':q<cr>')

vim.keymap.set('i', '<C-a>', '<home>')
vim.keymap.set('i', '<C-e>', '<end>')
vim.keymap.set('i', '<C-d>', '<del>')

vim.keymap.set('i', '<m-k>', '<up>')
vim.keymap.set('i', '<m-j>', '<down>')
vim.keymap.set('i', '<m-h>', '<left>')
vim.keymap.set('i', '<m-l>', '<right>')

vim.keymap.set('i', '<S-cr>', '<esc>o')

vim.keymap.set('n', '<C-\\>', '<cmd>vsplit<cr>')
vim.keymap.set('n', '<C-S-\\>', '<cmd>split<cr>')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- [[ 插件 ]]

-- Bootstrap lazy.nvim
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
vim.opt.rtp:prepend(lazypath)

-- 设置插件
require("lazy").setup({ 
    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "nvim-mini/mini.cursorword",
        version = '*',
        lazy = false,
        config = function(_, opts)
            require('mini.cursorword').setup()
        end
    },
    {
        "nvim-mini/mini.pairs",
        version = '*',
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            skip_ts = { "string" },
            skip_unbalanced = true,
            markdown = true,
        },
        config = function (_, opts)
            require('mini.pairs').setup()
        end
    },
    {
        'saghen/blink.cmp',
        version = '*',
        event = "InsertEnter",
        dependencies = {
            'mikavilpas/blink-ripgrep.nvim',
        },
        opts = {
            keymap = { 
                preset = 'super-tab',
            },
            appearance = {
                use_nvim_cmp_as_default = true,
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep' },
                providers = {
                    ripgrep = {
                        module = 'blink-ripgrep',
                        name = 'Ripgrep',
                    },
                },
            },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = "VeryLazy",
        lazy = vim.fn.argc(-1) == 0,
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "html",
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
                "yaml",
            },
        },
        config = function(_, opts)
            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            parser_config.c3 = {
                install_info = {
                    url = "https://github.com/c3lang/tree-sitter-c3",
                    files = {"src/parser.c", "src/scanner.c"},
                    branch = "main",
                },
                filetype = "c3"
            }

            if type(opts.ensure_installed) == "table" then
                require('nvim-treesitter.configs').setup(opts)
            end
        end,
    },
    {
        "ibhagwan/fzf-lua",
    },
})

vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<cr>', { desc = "(f)ind (f)ile" })
vim.keymap.set('n', '<leader>fs', '<cmd>FzfLua live_grep<cr>', { desc = '(f)ind (s)tring' })
vim.keymap.set('n', '<leader>fw', '<cmd>FzfLua grep_cword<cr>', { desc = '(f)ind current (w)ord'})

vim.o.background = 'dark'
-- vim.cmd[[colorscheme tokyonight]]
vim.cmd[[colorscheme vscode]]
if vim.g.neovide then
    vim.o.background = 'light'
    vim.cmd[[colorscheme vscode]]
end

