return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#0e1415',
				base01 = '#0e1415',
				base02 = '#848e8f',
				base03 = '#848e8f',
				base04 = '#dae6e8',
				base05 = '#f8feff',
				base06 = '#f8feff',
				base07 = '#f8feff',
				base08 = '#ff9fc0',
				base09 = '#ff9fc0',
				base0A = '#9de9f3',
				base0B = '#a5ffae',
				base0C = '#cff9ff',
				base0D = '#9de9f3',
				base0E = '#b4f6ff',
				base0F = '#b4f6ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#848e8f',
				fg = '#f8feff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#9de9f3',
				fg = '#0e1415',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#848e8f' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#cff9ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#b4f6ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#9de9f3',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#9de9f3',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#cff9ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffae',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#dae6e8' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#dae6e8' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#848e8f',
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
