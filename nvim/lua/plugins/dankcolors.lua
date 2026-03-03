return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#0f1512',
				base01 = '#0f1512',
				base02 = '#808b87',
				base03 = '#808b87',
				base04 = '#d3e0dc',
				base05 = '#f8fffc',
				base06 = '#f8fffc',
				base07 = '#f8fffc',
				base08 = '#ffbe9f',
				base09 = '#ffbe9f',
				base0A = '#a1ebd4',
				base0B = '#a5ffaa',
				base0C = '#d4fff1',
				base0D = '#a1ebd4',
				base0E = '#bdffea',
				base0F = '#bdffea',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#808b87',
				fg = '#f8fffc',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#a1ebd4',
				fg = '#0f1512',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#808b87' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#d4fff1', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#bdffea',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#a1ebd4',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#a1ebd4',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#d4fff1',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffaa',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#d3e0dc' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#d3e0dc' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#808b87',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
