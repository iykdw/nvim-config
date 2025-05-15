" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

filetype plugin indent on
set number
syntax enable

let maplocalleader="]"


"   LSP Actions
"
" Show available code actions
nnoremap <localleader>act :lua vim.lsp.buf.code_action()<CR>
" Rename token under cursor
nnoremap <localleader>ren :lua vim.lsp.buf.rename()<CR>
" Jump to definition
nnoremap <localleader>def :lua vim.lsp.buf.definition()<CR>
" Show all references
nnoremap <localleader>ref :lua vim.lsp.buf.references()<CR>
" Format code
nnoremap <localleader>fmt :lua vim.lsp.buf.format()<CR>

" Show file explorer
nnoremap <localleader>e :NERDTreeToggle<CR>

" Status Line

" Run Rust
nnoremap <localleader>cr :!cargo run<CR>
" Build Rust
nnoremap <localleader>cb :!cargo build<CR>
" Test Rust
nnoremap <localleader>ct :!cargo test<CR>

let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1

" TODO: fix wuth better symbols
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" Whitespace n such
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'dense-analysis/ale'
Plug 'cespare/vim-toml'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

colorscheme catppuccin

" Let nvim function inside a python virtualenv
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

" UltiSnips definitions
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="horizontal"

" ALE

let g:ale_linters={
\    'python': ['ruff', 'flake8', 'mypy', "pyright", "pydocstyle"],
\    'rust': ['cargo', 'analyzer'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\	'python': ['black', 'ruff', 'reorder-python-imports', "add_blank_lines_for_python_control_statements", "autopep8"],
\   'javascript': ['prettier'],
\   'rust': ['rustfmt'],
\}

let g:ale_rust_cargo_use_clippy = 1
let g:ale_detail = 1 " show detailed messages

" For some reason I need to it like this for tex
let g:ale_fixers['tex'] = get(g:ale_fixers, 'latexindent', []) + ['latexindent']

" Real-time LaTeX
nmap <localleader>fs <plug>(vimtex-view)
nmap <localleader>c <plug>(vimtex-compile)
let g:vimtex_view_method = 'skim'
let g:vimtex_compiler_latexmk = {'options' : ['-shell-escape', '-synctex=1'],}
let g:vimtex_compiler_method = 'latexmk'
set conceallevel=1
let g:tex_conceal='abdmg'
let g:ale_tex_latexindent_options='/opt/homebrew/bin/latexindent -m -'

" Reverse search from Skim
function! s:TexFocusVim() abort
  " Replace `TERMINAL` with the name of your terminal application
  silent execute "!open -a kitty"
  redraw!
endfunction


" Reverse search focus
augroup vimtex_event_focus
  au!
  au User VimtexEventViewReverse call s:TexFocusVim()
augroup END

" Fix gutentags
let g:gutentags_ctags_executable = '/opt/homebrew/bin/ctags'


" I only seem to need these for JS
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType javascriptreact setlocal shiftwidth=4 tabstop=4 expandtab
