return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',

	config = function()
		local ts = require('nvim-treesitter')

		ts.setup {
			install_dir = vim.fn.stdpath('data') .. '/site',
		}

		-- ensure installed 
		ts.install {
			'bash',
			'c',
			'lua',
		}

		-- activate treesitter for supported filetypes
		vim.api.nvim_create_autocmd('FileType', {
			callback = function(args)
				local ft = vim.bo[args.buf].filetype
				local lang = vim.treesitter.language.get_lang(ft)

				if not lang then
					return
				end

				-- is parser already installed?
				if vim.treesitter.language.add(lang) then
					vim.treesitter.start(args.buf, lang)

					-- Folding
					vim.wo.foldmethod = 'expr'
					vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

					-- Indentation, if Query is found
					if vim.treesitter.query.get(lang, 'indents') then
						vim.bo.indentexpr =
							"v:lua.require'nvim-treesitter'.indentexpr()"
					end

					return
				end
				
				-- parser available but not installed?
				if vim.tbl_contains(ts.get_available(), lang) then
					ts.install({ lang }):await(function()
						if vim.api.nvim_buf_is_valid(args.buf)
							and vim.treesitter.language.add(lang)
						then
							vim.treesitter.start(args.buf, lang)

							vim.wo[0][0].foldmethod = 'expr'
							vim.wo[0][0].foldexpr =
								'v:lua.vim.treesitter.foldexpr()'

							if vim.treesitter.query.get(lang, 'indents') then
								vim.bo[0][0].indentexpr =
									"v:lua.require'nvim-treesitter'.indentexpr()"
							end
						end
					end)
				end
			end,
		})
	end,
}
