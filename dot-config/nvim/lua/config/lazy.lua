-- Plugins spec
local plugins = {

	-- Core
	'nvim-lua/plenary.nvim',
	'nvim-tree/nvim-web-devicons',

	-- Colorscheme
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		opts = {
			style = 'night',
			on_highlights = function(hl, c)
				hl.TelescopeBorder = { fg = c.bg_dark, bg = c.bg_dark }
				hl.TelescopePromptBorder = { fg = c.bg_dark, bg = c.bg_dark }
				hl.TelescopePromptTitle = { fg = c.bg_dark, bg = c.bg_dark }

				hl.FloatBorder = { fg = c.bg_dark, bg = c.bg_dark }
			end,
		},
		config = function(_, opts)
			require('tokyonight').setup(opts)
			require('tokyonight').load()
		end,
	},

	-- Better syntax highlighting
	{
		'nvim-treesitter/nvim-treesitter',
		version = false,
		build = ':TSUpdate',
		event = { 'BufRead', 'BufNewFile' },
		opts = {
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
		config = function(_, opts)
			require('nvim-treesitter.configs').setup(opts)
		end,
	},

	-- Finders
	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		dependencies = {
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
			},
		},
		branch = '0.1.x',
		config = function()
			local tscope = require('telescope')
			tscope.setup({
				defaults = {
					color_devicons = false,
					prompt_prefix = '   ',
					-- selection_caret = ' ',
					selection_caret = ' ',
					entry_prefix = ' ',
				},
				pickers = {
					find_files = { theme = 'ivy' },
					help_tags = { theme = 'ivy' },
					live_grep = { theme = 'ivy' },
					highlights = { theme = 'ivy' },
				},
			})

			tscope.load_extension('fzf')
		end,
	},

	-- Autocompletion
	{
		'saghen/blink.cmp',
		event = { 'InsertEnter' },
		dependencies = {
			{
				'L3MON4D3/LuaSnip',
				version = 'v2.*',
				config = function()
					require('luasnip.loaders.from_snipmate').lazy_load()
				end,
			},
			{ 'onsails/lspkind.nvim', opts = {} },
		},
		version = '*',

		opts = {
			enabled = function()
				if vim.bo.buftype == 'acwrite' or vim.bo.buftype == 'prompt' then
					return false
				else
					return true
				end
			end,

			snippets = { preset = 'luasnip' },

			keymap = {
				preset = 'enter',

				['<C-j>'] = {
					function(cmp)
						cmp.snippet_forward()
					end,
				},

				['<C-k>'] = {
					function(cmp)
						cmp.snippet_backward()
					end,
				},
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'normal',
			},

			completion = {
				menu = {
					auto_show = function(ctx)
						return ctx.mode ~= 'cmdline'
					end,
					draw = {
						columns = {
							{ 'label', gap = 1 },
							{ 'kind_icon', 'kind' },
						},
						components = {
							kind_icon = {
								text = function(item)
									local kind = require('lspkind').symbol_map[item.kind] or ' '
									return kind .. ' '
								end,
							},
						},
						treesitter = { 'lsp' },
					},
				},
				ghost_text = { enabled = true },
				list = { selection = { preselect = false, auto_insert = true } },
			},

			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
				cmdline = {},
				providers = {
					lsp = { min_keyword_length = 2 },
					path = { min_keyword_length = 0 },
					snippets = { min_keyword_length = 2 },
					buffer = {
						min_keyword_length = 5,
						max_items = 5,
					},
				},
			},
		},
	},

	-- Language Server
	{
		'neovim/nvim-lspconfig',
		event = { 'BufRead', 'BufNewFile' },
		config = function()
			require('config.lspconfig')
		end,
	},

	-- Formatter
	{
		'stevearc/conform.nvim',
		event = { 'LspAttach', 'BufReadPost', 'BufNewFile' },
		opts = {
			format_on_save = {
				timeout_ms = 3500,
				lsp_format = 'fallback',
			},
			formatters_by_ft = {
				lua = { 'stylua' },
			},
		},
	},

	-- File Manager
	{
		'stevearc/oil.nvim',
		cmd = 'Oil',
		opts = {
			columns = {},
			float = {
				max_height = 20,
				max_width = 80,
				-- win_options = { number = false },
			},
			keymaps = {
				['<Left>'] = 'actions.parent',
				['<Right>'] = 'actions.select',
			},
		},
	},

	-- Git Frontend
	{
		'NeogitOrg/neogit',
		cmd = { 'Neogit' },
		opts = {
			commit_view = {
				kind = 'tab',
			},
		},
	},

	-- Better Writing Experience
	{
		'preservim/vim-pencil',
		ft = { 'markdown', 'text', 'gemtext', 'asciidoc' },
		config = function()
			vim.o.conceallevel = 2
			vim.g['pencil#wrapModeDefault'] = 'soft'
			vim.cmd([[call pencil#init()]])
		end,
	},
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'--branch=stable',
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
			{ '\nPress any key to exit...' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Lazy setup
require('lazy').setup({
	spec = plugins,
	defaults = { lazy = true },
	install = { colorscheme = { 'tokyonight' } },
	rocks = { enabled = false },
	checker = { enabled = false },
	change_detection = { enabled = false },
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true,
		rtp = {
			reset = true,
			paths = {},
			disabled_plugins = {
				'gzip',
				'matchit',
				'matchparen',
				'netrwPlugin',
				'tarPlugin',
				'tohtml',
				'tutor',
				'zipPlugin',
				'spellfile',
			},
		},
	},
})
