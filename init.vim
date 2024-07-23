" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat'
Plug 'dense-analysis/ale'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

colorscheme catppuccin

if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="horizontal"

let g:vimtex_view_method = 'skim'
let g:vimtex_compiler_latexmk = {'options' : ['-shell-escape', '-synctex=1'],}
let g:vimtex_compiler_method = 'latexmk'
set conceallevel=1
let g:tex_conceal='abdmg'

let g:ale_tex_latexindent_options='/opt/homebrew/bin/latexindent -m -'
let g:ale_linters={
\    'python': ['ruff', 'flake8']
\}
let g:ale_fixers = {
\	'python': ['black', 'ruff'],
\   'javascript': ['prettier'],
\}
let g:ale_fixers['tex'] = get(g:ale_fixers, 'latexindent', []) + ['latexindent']

let g:ale_fix_on_save = 1


filetype plugin indent on

syntax enable

let maplocalleader="]"
nmap <localleader>fs <plug>(vimtex-view)
nmap <localleader>c <plug>(vimtex-compile)

set number

function! s:TexFocusVim() abort
  " Replace `TERMINAL` with the name of your terminal application
  " Example: execute "!open -a iTerm"  
  " Example: execute "!open -a Alacritty"
  silent execute "!open -a Terminal"
  redraw!
endfunction

augroup vimtex_event_focus
  au!
  au User VimtexEventViewReverse call s:TexFocusVim()
augroup END

set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType javascriptreact setlocal shiftwidth=4 tabstop=4 expandtab

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

