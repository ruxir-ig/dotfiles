return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#0e1415',
				base01 = '#0e1415',
				base02 = '#828c8d',
				base03 = '#828c8d',
				base04 = '#d6e3e3',
				base05 = '#f8feff',
				base06 = '#f8feff',
				base07 = '#f8feff',
				base08 = '#ff9fc1',
				base09 = '#ff9fc1',
				base0A = '#9beaee',
				base0B = '#a5ffad',
				base0C = '#cffcff',
				base0D = '#9beaee',
				base0E = '#b5faff',
				base0F = '#b5faff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#828c8d',
				fg = '#f8feff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#9beaee',
				fg = '#0e1415',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#828c8d' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#cffcff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#b5faff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#9beaee',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#9beaee',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#cffcff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffad',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#d6e3e3' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#d6e3e3' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#828c8d',
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
