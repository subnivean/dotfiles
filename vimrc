source $VIMRUNTIME/vimrc_example.vim

let g:explStartRight=0    " Put new explorer window to the left of the
                          " current window
let g:explVertical=1      " Split vertically
"let loaded_matchit = 1    " Skip 'matchit' loading until I can make it work

"set encoding=utf-8
"set encoding=latin1
"set fileencodings=utf-8
set fileencodings=latin1
set nocompatible
set autowrite
set nobk
"set tabstop=4
"set shiftwidth=4
set tabstop=2
set shiftwidth=2
set incsearch
set hlsearch
set expandtab
set lines=60
set columns=80
"set textwidth=75
set textwidth=0
set guifont=Monospace\ 8
" modeline is what allows you to put things like:
" # vim: set filetype=perl expandtab tabstop=4 shiftwidth=4 autoindent smartindent nu:
" at or near the bottom a file (i.e. file-specific vim settings)
set modeline
set autoindent
"Turn off right gui scrollbars
set guioptions-=r
set guioptions-=T
"Turn off all bells, visual or otherwise (oops - still get visual bell)
set noerrorbells
"set visualbell
set t_vb= " damn - still get visual bell, even after this
"set guifont=LucidaTypewriter\ 9
syntax on
"colors koehler
colors xoria256
"colorscheme murphy

call pathogen#infect()

"filetype plugin on
filetype indent plugin on

map S :%!./subit.pl
"map  :0r ./header.txt

map <c-w><c-f> :FirstExplorerWindow<cr>
map <c-w><c-b> :BottomExplorerWindow<cr>
map <c-w><c-t> :WMToggle<cr>

" Change those '$this = $that if $foo == $bar;' lines into a proper block
map <silent> <F5> 0/ if <cr>xi<cr><esc>wi(<esc>$xa) {<esc>kddp$a;<cr>}<esc>=%:nohlsearch<cr>
map <silent> <Leader>nh :nohls<CR>
vmap <silent> <Leader>a <ESC>:'<,'>!~/.vim/scripts/align.pl<CR>

abbr teh the
abbr adn and
abbr DEGUB DEBUG
abbr degub debug

" Added the following lines on 2005-06-12 to fix backspace key issue (^?
" characters)
imap <c-?> <BS>
:fixdel

runtime! macros/matchit.vim

augroup myfiletypes
  " Clear old commands in group
  autocmd!
  " Autoindent with two spaces, always expand tabs
  autocmd FileType perl set ai sw=4 sts=4 et
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml source ~/.vim/ruby-macros.vim
  autocmd Filetype ruby,eruby,yaml set omnifunc=rubycomplete#Complete
augroup END

set complete+=k
autocmd FileType * exec('set dictionary+=~/.vim/dict/' . &filetype . '.dict')
""""
"""" Removes trailing spaces
"""" Got this from here on 2010-02-13:
"""" http://www.google.com/url?sa=t&source=web&ct=res&cd=1&ved=0CAcQFjAA&url=http%3A%2F%2Fvim.wikia.com%2Fwiki%2FRemove_unwanted_spaces&ei=kNR2S_utAcel8AawtuzzCQ&usg=AFQjCNHZHgZOq2_f9dL_LMXf9nZrcqhKHA&sig2=uPRT8RdZzEFBhggz9urT4Q
"""" Originally, I tried this:
""""
"""" autocmd BufWritePre * :%s/\s\+$//e
""""
"""" but I kept getting a 'Not an editor command' error. WTF?
"""" MSK
"""function TrimWhiteSpace()
"""  %s/\s*$//
"""  ''
""":endfunction
"""
""""set list listchars=trail:.,extends:>
"""autocmd FileWritePre * :call TrimWhiteSpace()
"""autocmd FileAppendPre * :call TrimWhiteSpace()
"""autocmd FilterWritePre * :call TrimWhiteSpace()
"""autocmd BufWritePre * :call TrimWhiteSpace()

map <F2> :call TrimWhiteSpace()<CR>
map! <F2> :call TrimWhiteSpace()<CR>

set diffopt+=iwhite
