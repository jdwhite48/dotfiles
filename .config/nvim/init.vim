set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" ================================
" Linting (Coc / ALE)
" ================================

" TODO: Consider changing Cocc triggers (<C-y> to autocomplete, <C-p> / <C-n> to go up / down the list)

" NOTE: If not found, explicitly tell Coc where Node is on this machine
"let g:coc_node_path = '/usr/local/bin/node'
" Forward diagnostic info to ALE instead of LSP server before loading plugins (see :CocConfig)
let g:ale_disable_lsp = 1
 
" Rust
" --------------------------------
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 3		" 3000 ms delay between timeout and linting

call plug#begin('~/.config/nvim/plugged')
	" Vim / Neovim
	Plug 'rust-lang/rust.vim'	" Rust formatting (Vim 8+)
	Plug 'dense-analysis/ale'	" Dynamic linter; LSP client (nvim 0.2+, Vim 8+)
	Plug 'tbastos/vim-lua'

	" Neovim-only
	Plug 'neoclide/coc.nvim', {'branch': 'release'}	" IDE features; LSP client (Neovim 0.4+ or Vim 0.8+; NodeJS 14.14+)
	Plug 'rcarriga/nvim-notify'		" Prettier notifications in sidebar
	Plug 'navarasu/onedark.nvim'	" Colorscheme (Neovim 0.5+)
call plug#end()

" Onedark colorscheme
let g:onedark_config = {
	\ 'style': 'deep',
\}
colorscheme onedark

source ~/.vimrc
