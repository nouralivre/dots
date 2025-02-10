vim.keymap.set(
	'n',
	'<leader><leader>',
	':Telescope find_files<cr>',
	{ desc = 'File Finders' }
)
vim.keymap.set('n', '<leader>d', function()
	require('oil').open_float()
end, { desc = 'Open Popup Directory' })
vim.keymap.set('n', '<leader>gg', ':Neogit<cr>', { desc = 'Open Neogit' })
vim.keymap.set(
	'n',
	'<leader>xx',
	':Trouble diagnostics open<cr>',
	{ desc = 'Open Diagnostics Panel' }
)
vim.keymap.set(
	'n',
	'<leader>ww',
	':Telescope workspaces theme=ivy<cr>',
	{ desc = 'Show All Workspaces' }
)
vim.keymap.set('n', '<localleader>l', ':Lazy<cr>', { desc = 'Open Lazy' })

vim.keymap.set('v', 'k', ":m '<-2<cr>gv=gv", { desc = 'Indent up' })
vim.keymap.set('v', 'j', ":m '>+1<cr>gv=gv", { desc = 'Indent Down' })

vim.keymap.set(
	'n',
	'<leader>fg',
	':Telescope live_grep<cr>',
	{ desc = 'Find Grep' }
)
vim.keymap.set(
	'n',
	'<leader>fh',
	':Telescope help_tags<cr>',
	{ desc = 'Find Help' }
)
vim.keymap.set(
	'n',
	'<leader>fl',
	':Telescope highlights<cr>',
	{ desc = 'Find Highlights' }
)

vim.keymap.set({ 'n', 'x' }, 's', '<Bop>')

vim.api.nvim_create_augroup('UserLspConfig', {})
vim.api.nvim_create_autocmd('LspAttach', {
	group = 'UserLspConfig',
	callback = function(ev)
		vim.keymap.set(
			'n',
			'<leader>e',
			vim.diagnostic.open_float,
			{ desc = 'Open Diagnostic Float', buffer = ev.buf }
		)
		vim.keymap.set(
			'n',
			'[d',
			vim.diagnostic.goto_prev,
			{ desc = 'Go to previous diagnostic', buffer = ev.buf }
		)
		vim.keymap.set(
			'n',
			']d',
			vim.diagnostic.goto_next,
			{ desc = 'Go to next diagnostic', buffer = ev.buf }
		)
		vim.keymap.set(
			'n',
			'<leader>q',
			vim.diagnostic.setloclist,
			{ desc = 'Send buf diagnostics to loclist', buffer = ev.buf }
		)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf })
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf })
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf })
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf })
		vim.keymap.set(
			'n',
			'<C-k>',
			vim.lsp.buf.signature_help,
			{ buffer = ev.buf }
		)
		vim.keymap.set(
			'n',
			'<leader>D',
			vim.lsp.buf.type_definition,
			{ buffer = ev.buf }
		)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf })
		vim.keymap.set(
			{ 'n', 'v' },
			'<leader>ca',
			vim.lsp.buf.code_action,
			{ buffer = ev.buf }
		)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf })
		-- vim.keymap.set('n', '<leader>f', function()
		-- 	vim.lsp.buf.format({ async = true })
		-- end, opts)
	end,
})
