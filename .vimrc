set number!                                                     
set autoindent
set backspace=indent,eol,start
set visualbell
set t_vb=
set tabstop=4
set shiftwidth=4
set expandtab
set wildmenu
set wildmode=list:longest
set encoding=utf-8
set nowrap
set completeopt-=preview
set cursorline
set termguicolors

call plug#begin('~/.vim/plugged')

Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'beikome/cosme.vim'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-webdevicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}


call plug#end()

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

let g:webdevicons_enable_nerdtree = 1

let g:indentLine_char = '|'

set background=dark
"colorscheme cosme
colorscheme catppuccin_macchiato

let g:lightline = {
\ 'colorscheme': 'catppuccin_macchiato',
\
\ 'component_function': {
\   'filetype': 'MyFiletype',
\   'fileformat': 'MyFileformat',
\  }
\}

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
map <C-s> :write<CR>
map q :quit<CR>

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap a  <Plug>(coc-codeaction)
nmap f  <Plug>(coc-fix-current)
