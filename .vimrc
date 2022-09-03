" ================================
" Imported plugins (Vim-plug)
" ================================

" Automatically install vim-plug if not found
if has('nvim')
else
	" Automatically install vim-plug if not in /autoload (Vim-only)
	let data_dir = '~/.vim'
	if empty(glob(data_dir . '/autoload/plug.vim'))
		silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

	" Forward Coc linting diagnostic info to ALE instead of LSP server before loading plugins (see :CocConfig)
	"let g:ale_disable_lsp = 1
	call plug#begin()
"	Plug 'rust-lang/rust.vim'
	Plug 'dense-analysis/ale'				" Dynamic linter; LSP client (nvim 0.2+, Vim 8+)
	Plug 'tbastos/vim-lua'
	call plug#end()
endif

" ================================
" General
" ================================

" set cursorline

" Auto-reload when files are externally changed (but not mid-macro execution)
set autoread lazyredraw

" Make undo history persistent on-disk
if has('nvim')
	set undofile undodir=~/.config/nvim/undo
else
	set undofile undodir=~/.vim/undo
endif

" Set clipboard for vim
set clipboard=unnamed,unnamedplus

" Show line numbers and current position
set number ruler

" (***IMPURE VIM USER ALERT***) Use mouse to click and scroll in normal or
" visual mode. Because I'm lazy and don't want to figure out WSL clipboard,
" mouse is disabled in insert mode to right-click paste from Windows
set mouse=nv

" Buffer to allow reuse of the same window & keeps undo history
set hidden

" When auto-completing, provides a graphical menu of all the matches to cycle through
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Use visual bell instead of annoying beeping on errors
set visualbell

" Use tabs with 4-space-width ;)
set noexpandtab
set shiftwidth=4 softtabstop=4 tabstop=4
set autoindent smartindent

" Always wrap long lines
set wrap
" Left and right arrow keys will move lines if these chars at the start or end
set whichwrap+=<,>,[,],

" Backspace works over line breaks, inserts, and autoindents
set backspace=eol,start,indent

" Define <leader> for extra key combinations
let mapleader=","
" Toggle spellchecker
map <leader>ss :setlocal spell!<cr>

" Autoindent entire file in normal mode
nnoremap <leader>I gg=G

" Remove Windows ^M from different line encodings (untested)
" noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm


" ================================
" Set ~~ A E S T H E T I C ~~
" ================================

" Assume UTF-8 file encoding by default (not down-converted to Latin-1)
set encoding=utf8

if has('nvim')
	" see [.config/nvim/init.vim]
else
	if has('mac') || has('gui_macvim')
		set termguicolors bg=dark
	else
		"colorscheme desert
		"colorscheme elflord
		"colorscheme blue
		"colorscheme torte
		set bg=dark
		colorscheme torte
	endif
endif

" ================================
" Syntax/Search Highlighting
" ================================

" Enable (supported) syntax highlighting
syntax enable

" Load filetype-specific indent files/plugins
filetype indent on
filetype plugin on

" Highlight search results, as you type, (default) case-sensitive
set hlsearch incsearch
"set nohls

" Show matching brackets
set showmatch
set mat=2

" Clear search highlighting
map <leader>hlx :noh <cr>


" ================================
" Fix / pre-empt common typos
" ================================
" correct :W to :w
cnoreabbrev <expr> W((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
" correct :Q to :q
cnoreabbrev <expr> Q((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))

" Automatically close brackets (monkey hands too used to manually typing these and 
" I'm too lazy to handle typing right bracket being treated as itself :)
"inoremap ( ()<LEFT>
"inoremap [ []<LEFT>
"inoremap { {}<LEFT>

" Fix trailing whitespace on save for the below filetypes 
fun! CleanTrailingSpaces()  
	let save_cursor = getpos(".")
	let old_query = getreg("/")
	silent! %s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfun
if has("autocmd")
	autocmd BufWritePre *.js,*.rs,*.c,*.cpp,*.h,*.hpp,*.py,*.sh,*.v :call CleanTrailingSpaces()
endif


" ================================
" Nerdy Stuff
" ================================

" Auto binary-hex conversions (WARNING: Modifies the files)
command B2H %!xxd
command H2B %!xxd -r

" Rust configuration (rust-vim)
" --------------------------------
" specify g:rustc_path?
" Automatically run `:RustFmt` when you save a buffer
"let g:rustfmt_autosave = 1
" modify g:rustfmt_command, g:rustfmt_options

" Tex configuration
" -------------------------------
"  TODO: VimTeX + ALE (linter) + Zathura / pdf-poppler (PDF viewer)
"  See :help vimtex-faq-wsl and vimtex-view-zathura and vimtex-synctex

" TODO: Refactor to define file extension-dependent settings with autocmd /
" setlocal (e.g., tab behavior)
" Coq
"nnoremap <silent> <C-Left> :CoqStop<CR>
"nnoremap <silent> <C-Right> :CoqStart <bar> :CoqToLine<CR>
"nnoremap <silent> <C-Up> :CoqUndo<CR>
"nnoremap <silent> <C-Down> :CoqNext<CR>
