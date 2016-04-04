set nocompatible " vim > vi mode.
"set shell=bash\ --login
set viminfo='10000,<5000,s1000,h
set tags+=./tags,./ruby-tags,./.git/tags;

let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

source $HOME/.config/nvim/init.bundles

set runtimepath+=~/.fzf

syntax enable
syntax sync fromstart

" BASIC EDITING CONFIGURATION
set autoindent          " Copy indent from current line when starting a new line
set backspace=2         " makes backspace work normally
set cmdheight=1         " Cmd bar 2 rows high
set complete+=kspell
set completeopt=menu
set cursorline            " highlight current line
set expandtab           " Use spaces not tabs
set exrc                " allow local .vimrc files per project
set hidden              " allow unsaved background buffers and remember marks/undo for them
set history=10000       " remember more commands and search history
set hlsearch              " Highlight searches and search results
set ignorecase smartcase  " make searches case-sensitive only if they contain upper-case characters
set incsearch             " Show best match while typing a search
set laststatus=2          " Always show the status line
set lazyredraw
set linebreak           " Don't wrap text in the middle of a word
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set matchtime=2         " for .2 seconds
set nobackup
set noerrorbells        " No noise
set nojoinspaces        " Use only 1 space after "." when joining lines instead of 2
set nopaste
set nostartofline       " Don't reset cursor to start of line when moving around
set novisualbell        " No blinking
set nowrap
set nowritebackup
set number              " Show line numbers
set numberwidth=1       " Try to use only 1 col when possible
set report=0            " : commands always print changed line count
set ruler               " Display position in the file
set scrolloff=5         " Keep 5 lines (top/bottom) for scope
set shiftwidth=2        " Indent level is 2 spaces wide
set shortmess=atI       " The "Press ENTER or type command to continue" prompt is jarring and usually unnecessary.
set showcmd             " Show partial command in the last line of the screen
set showmatch            " Show matched paren when balanced
set showtabline=2
set smartindent
set smarttab            " Insert blanks properly at beginning of a line
set softtabstop=2       " <BS> over an autoindent deletes shiftwidth worth of spaces
set splitbelow
set splitright
set swapfile
set switchbuf=""        " do not move focus/cursor to where the buffer is already open
set synmaxcol=1200      " Syntax coloring lines that are too long just slows down the world
set t_ti= t_te=         " Prevent Vim from clobbering the scrollback buffer
set tabstop=2           " Use 2 spaces for <tab>
set tagbsearch          " use binary searching for tags
set ttyfast
if v:version > 702
  set undofile
  set undoreload=10000
endif
set undolevels=1000
set vb t_vb=            " No bells. Period.
set wildignore+=*/tmp/*,*/.git/*,*.so,*.swp,*.zip,*/log/*
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=longest,list,full  " First list the available options and complete the longest common part, then have further <Tab>s cycle through the possibilities:

let mapleader = " "     " change <leader> from \ to <space>

" Per-Filetype Scripts
filetype on             " File type detection on
filetype indent on      " Use filetype-specific indenting when available
filetype plugin on      " Load filetype plugins

set ofu=syntaxcomplete#Complete
set omnifunc=rubycomplete#Complete

autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType sql setlocal omnifunc=sqlcomplete#CompleteSQL
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_use_bundler = 1
let g:ruby_operators = 1

" clear highlighted search using the space bar
nnoremap \ :nohlsearch<CR>

" make ctrl i increment numbers instead of ctrl a
" noremap <C-i> <C-a>
noremap <leader>i <C-a>

" Stay in visual mode after >>
vnoremap << <gv
vnoremap >> >gv
nnoremap ,gf magg<S-v>G=`a

set notimeout ttimeout ttimeoutlen=100

if exists('+colorcolumn')
  set colorcolumn=80
else
  match ErrorMsg '\%>80v.\+'
end

" Navigate panes vim style
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <Left> <C-w><
map <Down> <C-w>+
map <Up> <C-w>-
map <Right> <C-w>>

" Yank/Paste to system clipboard settings
if has('unnamedplus')
  vmap ,p "+p
  vmap ,P "+P
  vmap ,y "+y
  vmap ,Y "+Y
  nmap ,p "+p
  nmap ,P "+P
  nmap ,y "+y
  nmap ,Y "+Y
else
  vmap ,p "*p
  vmap ,P "*P
  vmap ,y "*y
  vmap ,Y "*Y
  nmap ,p "*p
  nmap ,P "*P
  nmap ,y "*y
  nmap ,Y "*Y
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
"   " (happens when dropping a file on gvim).
" autocmd BufReadPost *
"       \ if line("'\"") > 0 && line("'\"") <= line("$") |
"       \   exe "normal g`\"" |
"       \ endif

" Spelling
set spell spelllang=en_us
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" Solarized Settings
if isdirectory(expand("~/.config/nvim/plugged/vim-colors-solarized"))
  let g:solarized_termtrans=1
  let g:solarized_termcolors=16
  colorscheme solarized
  set t_Co=256
  set background=dark
endif

" CTRLP Settings
let g:ctrlp_match_window_reversed=0
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_show_hidden=0
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
" let g:ctrlp_user_command = 'ag %s --smart-case --nogroup --nocolor --hidden
"       \ --ignore .git
"       \ --ignore .svn
"       \ --ignore .hg
"       \ --ignore .DS_Store
"       \ --ignore node_modules
"       \ --ignore tags
"       \ -g ""'
let g:ctrlp_lazy_update = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_mruf_relative = 1
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>m :CtrlPMRU<CR>

" Ag Settings
let g:ag_highlight=1
let g:ag_prg='ag --smart-case --column
      \ --nogroup
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore node_modules
      \ --ignore tags
      \ '

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" YankStack settings
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" NERD Tree Settings
map <leader>f :NERDTreeFind<CR>
map <leader>n :NERDTreeToggle %:p:h<CR>

" Syntastic Settings

let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

let g:syntastic_quiet_messages = {}

let g:syntastic_always_populate_loc_list = 2
let g:syntastic_auto_loc_list = 1
let g:syntastic_auto_jump = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5
map <leader>l :lopen<CR>

" Rspec Settings
let g:rspec_command = "Dispatch rspec {spec}"
"map <leader>a :Dispatch rspec<CR>
"map <leader>r :Dispatch rspec %<CR>

" Tabgar Settings
map <leader>tb :TagbarToggle<CR>
map <leader>tc :TagbarCurrentTag s<CR>
let g:tagbar_autofocus=1

" Tabularize Settings
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>

" Easy Align settings
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" EasyMotion Settings
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'

" Session Settings
let g:session_autosave = 'no'

" let g:python_host_prog = '/usr/local/bin/python'
" let g:python3_host_prog = '/usr/local/bin/python3'

" YCM Settings
" let g:ycm_path_to_python_interpreter="/usr/bin/python"
" let g:ycm_add_preview_to_completeopt = 0
" let g:ycm_auto_trigger = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_seed_identifiers_with_syntax = 1

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" UltiSnip Settings
" let g:UltiSnipsExpandTrigger = '<C-l>'
" let g:UltiSnipsJumpForwardTrigger = '<C-j>'
" let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
"let g:UltiSnipsListSnippets = '<C-m>'

" indent-guides settings
"let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=Yellow
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=Black

" Folding
set foldmethod=manual "even with nofoldenable foldmethod=syntax causes slow ins-completions"
set foldlevel=1
set foldnestmax=10
set nofoldenable

" vim-instant-markdown
let g:instant_markdown_autostart = 1

" Goldenview
let g:goldenview__enable_default_mapping = 0

" Airline Settings
let g:airline_theme='solarized'

" vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_auto_type_info = 0
autocmd FileType go setlocal nolist ts=4 sw=4 sts=4
autocmd BufNewFile,BufRead *.go setlocal nolist ts=4 sw=4 sts=4

" closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx"

" unimpaired
" Bubble single lines
nmap <leader>k [e
nmap <leader>j ]e

vmap <leader>k [egv
vmap <leader>j ]egv
" Bubble multiple lines

" javascript-libraries-syntax
let g:used_javascript_libs = 'jquery,angularjs,react'

" Quickly edit/reload the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,eb :e $HOME/.config/nvim/init.bundles<CR>
nmap <silent> ,sv :source $MYVIMRC<CR>

if filereadable(expand("~/.config/nvim/init.vim.local"))
  source $HOME/.config/nvim/init.vim.local
endif
