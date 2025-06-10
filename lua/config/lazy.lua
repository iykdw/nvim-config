-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.print(lazypath)
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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "]"

vim.wo.number = true
vim.cmd("syntax enable")

vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- UltiSnips definitions
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<c-z>"
vim.g.UltiSnipsEditSplit = "horizontal"

-- vim.g.lazyvim_python_lsp = "pyright"
vim.diagnostic.config({ virtual_text = true })
-- For some reason I need to it like this for tex
-- vim.g.ale_fixers['tex'] = get(g:ale_fixers, 'latexindent', []) + ['latexindent']

-- Real-time LaTeX
--vim.api.nvim_set_keymap('n', 'fs', '<plug>(vimtex-view)', {noremap=true, silent=true});
--vim.api.nvim_set_keymap('n', 'c', '<plug>(vimtex-compile)', {noremap=true, silent=true});
--vim.g.vimtex_view_method = 'skim'
--vim.g.vimtex_compiler_latexmk = {'options' : ['-shell-escape', '-synctex=1'],}
--vim.g.vimtex_compiler_method = 'latexmk'
--set conceallevel=1
--vim.g.tex_conceal='abdmg'
--vim.g.ale_tex_latexindent_options='/opt/homebrew/bin/latexindent -m -'
--
---- Reverse search from Skim
--function! s:TexFocusVim() abort
--  -- Replace `TERMINAL` with the name of your terminal application
--  silent execute "!open -a kitty"
--  redraw!
--endfunction
--
--
---- Reverse search focus
--augroup vimtex_event_focus
--  au!
--  au User VimtexEventViewReverse call s:TexFocusVim()
--augroup END

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin-mocha" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

vim.cmd.colorscheme("catppuccin-mocha")
