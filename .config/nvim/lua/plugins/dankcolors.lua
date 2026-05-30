return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#161217',
				base01 = '#161217',
				base02 = '#9b929e',
				base03 = '#9b929e',
				base04 = '#faefff',
				base05 = '#fdf8ff',
				base06 = '#fdf8ff',
				base07 = '#fdf8ff',
				base08 = '#ff9fae',
				base09 = '#ff9fae',
				base0A = '#efc8ff',
				base0B = '#a5ffbc',
				base0C = '#f6e2ff',
				base0D = '#efc8ff',
				base0E = '#f1d2ff',
				base0F = '#f1d2ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#9b929e',
				fg = '#fdf8ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#efc8ff',
				fg = '#161217',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#9b929e' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#f6e2ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#f1d2ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#efc8ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#efc8ff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#f6e2ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffbc',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#faefff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#faefff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#9b929e',
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
