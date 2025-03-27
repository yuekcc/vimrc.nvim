vim.opt.mouse = 'a'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.confirm = true
vim.g.editorconfig = true

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

vim.opt.guifont = 'Maple Mono Normal NF CN:h13'

-- [[ 搜索设置 ]]
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- [[ 编辑设置 ]]

vim.opt.swapfile = false
vim.opt.undofile = false

vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4


-- [[ keymaps ]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')

vim.keymap.set('n', '<leader>w', ':w<cr>')
vim.keymap.set('n', '<leader>q', ':q<cr>')

vim.keymap.set('i', '<C-a>', '<home>')
vim.keymap.set('i', '<C-e>', '<end>')
vim.keymap.set('i', '<C-d>', '<del>')

vim.keymap.set('i', '<m-j>', '<up>')
vim.keymap.set('i', '<m-k>', '<down>')
vim.keymap.set('i', '<m-h>', 'left>')
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
        -- "folke/tokyonight.nvim",
        "olimorris/onedarkpro.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "echasnovski/mini.pairs",
        version = '*',
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            skip_ts = { "string" },
            skip_unbalanced = true,
            markdown = true,
        },
    },
    {
        'saghen/blink.cmp',
        version = '*',
        dependencies = {
            'mikavilpas/blink-ripgrep.nvim',
        },
        opts = {
            keymap = { preset = 'default' },
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
vim.keymap.set('n', '<leader>ss', '<cmd>FzfLua live_grep<cr>', { desc = '(s)earch (s)ring' })
vim.keymap.set('n', '<leader>sw', '<cmd>FzfLua grep_cword<cr>', { desc = '(s)earch current (w)ord'})

-- vim.cmd[[colorscheme tokyonight]]
-- vim.cmd[[colorscheme onelight]]
vim.cmd[[colorscheme onedark]]




