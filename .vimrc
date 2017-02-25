" README {
" vim: set foldmarker={,} foldlevel=0 spell:
"
"    This is my personal vim configuration. As quite a lot of effort went into
"    it, I would be glad if this was useful for anybody else than me.
"
"    Feel free to ask question or reuse any useful parts.
"
"    I also periodically sync my current vimrc to Github, so feel free to grab
"    the current version from there:
"        https://github.com/Flowm/vimrc
" }

" Basic {
    "Use vim defaults
    set nocompatible
    "Disable filetype detection during init
    filetype off
    "Enable Syntax highlighting
    syntax enable
    "Explicitly define xterm as environment
    behave xterm
    "More screen updates
    set ttyfast
    "Enable modelines, secured by ciaranm/securemodelines
    set modeline
    "No exec
    set secure
    "Encoding
    set encoding=utf-8
    "Remove splash screen
    set shortmess+=I
    "Function of the backspace key
    set backspace=indent,eol,start

    set noswapfile
" }

" Vundle with automatic setup {
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle..i."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#begin()

    Plugin 'gmarik/vundle'

    " Enhanced usability
    Plugin 'scrooloose/syntastic'
    Plugin 'scrooloose/nerdtree'
    Plugin 'Xuyuanp/nerdtree-git-plugin'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'ciaranm/securemodelines'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'editorconfig/editorconfig-vim'

    " Languages and related
    Plugin 'chase/vim-ansible-yaml'
    Plugin 'hail2u/vim-css3-syntax'
    Plugin 'chrisbra/csv.vim'
    Plugin 'jelera/vim-javascript-syntax'
    Plugin 'rodjek/vim-puppet'
    Plugin 'tpope/vim-bundler'
    Plugin 'tpope/vim-rails'
    Plugin 'vim-ruby/vim-ruby'
    Plugin 'lepture/vim-jinja'

    " Styling
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'godlygeek/tabular'
    Plugin 'junegunn/vim-emoji'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'

    " Experimental
    Plugin 'xolox/vim-easytags'
    Plugin 'xolox/vim-misc'
    Plugin 'majutsushi/tagbar'

    if iCanHazVundle == 0
        echo "Installing Plugins, please ignore key map error messages"
        echo ""
        :PluginInstall
    endif

    call vundle#end()
    filetype plugin indent on
" }

" General {
    " Backup and temporary files {
         set backup
         set backupdir=~/.vim/.vimbak
         set undofile
         set undodir=~/.vim/.vimundo
         set directory=~/.vim/.vimtmp,.
         set history=2048
         set undolevels=2048
    " }
    " Tab completion {
        set wildmenu
        set wildmode=list:longest,list:full
        set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
    " }
    " Searching {
        "Highlightsearch
        set hlsearch
        "Start searching with the first character
        set incsearch
        "Ignore case
        set ignorecase
        "Match case if searchstring starts with uppercase
        set smartcase
        "Global search by default
        set gdefault
        "Treat more characters as special (like in perl) when searching (e.g. . *)
        set magic
    " }
    " Spelling {
        set spelllang=en
    " }
    " Misc {
        " Only one whitespace after _J_oining after a dot
        set nojoinspaces
        " Disable autoselection of vim clipboard
        set clipboard-=autoselect
        set guioptions-=a
        " Use the best available cryptmethod
        if has("patch-7.4.399")
            set cryptmethod=blowfish2
        endif
    " }
" }

" Appearance and handling {
    " Theme {
        " Use a portable version of solarized in all terminals except iterm
        if $LC_TERM != 'iterm'
            let t_Co=256
            let g:solarized_termcolors=256
            let g:solarized_termtrans=1
        endif
        " Set colorscheme to solarized
        colorscheme solarized
        " Use the dark version of solarized
        set background=dark
    " }
    " Color tweaks {
        " Used by listchars
        hi Search ctermbg=DarkYellow ctermfg=White
        hi SpecialKey ctermbg=4

        "hi Identifier ctermfg=6 cterm=bold
            " 0 black, 1 darkred, 2 darkgreen, 3 darkyellow, 4 darkblue, 5 darkmagenta, 6 darkcyan, 7 grey
            " Non-safe Colors, 16-Color-Term:
            " darkgrey, lightblue, lightgreen, lightcyan, lightred, lightmagenta, " lightyellow, white
    " }
    " Statusbar {
        "Renaming xterm window
        set title
        "Don't show line numbers
        set nonumber
        "Always show the status bar
        set laststatus=2
    " }
    " Misc Handling {
        "Always let 5 lines below and above the cursor on the screen
        set scroll=11
        set scrolloff=5
        set sidescroll=8
        "Bracket matching
        set showmatch
        "Show unfinished commands
        set showcmd
        "No Bell
        set noerrorbells visualbell
        set mouse=
    " }
" }

" Text Formatting/Layout {
    " Whitespace and Tab display {
        set nolist
        "set list listchars=tab:>.,trail:.
        set listchars=tab:\ \ ,trail:\.
        "set list listchars=tab:>.,trail:�
    " }
    " Overlong lines display {
        "Don't do newlines automatically
        set fo-=t
        "Scroll right by default instead of breaking the line
        set nowrap
        "Don't stat a new line automatically break lines
        set wrapmargin=0
        "But continue with a mark in the next line
        set showbreak=>>>
    " }
    " Indention {
        "One Tab per indentation level. 4 column wide Tabs.
        "Intelligently detect current indention level
        set autoindent
        "Size of real Tabs
        set tabstop=4
        "Indent amount when using TAB
        set softtabstop=4
        "Indent amount when using cindent, >>, ..
        set shiftwidth=4
        "Do not expand tabs to spaces
        set noexpandtab
    " }
    " Folding (disabled) {
        "Disable folding completely
        "set nofoldenable
        "Disable folding in the initial view
        set foldlevel=20
        "Make folding indent sensitive
        set foldmethod=indent
    " }
" }

" Mappings and functions {
    " Misc {
        "Easier escape
        inoremap jj <ESC>
        inoremap ,, <ESC>
        "Match brackets key
        nnoremap <tab> %
        vnoremap <tab> %
        "Clear highlight
        map <silent> <C-l> :silent nohl<CR>
        "Save as root
        cmap w!! %!sudo tee > /dev/null %
    " }
    " Custom Keyset {
        let mapleader = ","
        "Reselect just pasted content
        nnoremap <leader>v V`]
        "Split Window and switch over to it
        nnoremap <leader>w <C-w>v<C-w>l
        nnoremap <leader>w <C-w>h<C-w>l
    " }
    " C&P between files via a tempfile {
        "Copy to buffer
        vnoremap <leader>y :w! ~/.vim/.vimbak/vimbuffer<CR>
        nnoremap <leader>y :.w! ~/.vim/.vimbak/vimbuffer<CR>
        "Paste from buffer
        nnoremap <leader>p :r ~/.vim/.vimbak/vimbuffer<CR>
        nnoremap <leader>P :-r ~/.vim/.vimbak/vimbuffer<CR>
    " }
    " Disable arrow keys by default {
    "    nnoremap <up> <nop>
    "    nnoremap <down> <nop>
    "    nnoremap <left> <nop>
    "    nnoremap <right> <nop>
    "    inoremap <up> <nop>
    "    inoremap <down> <nop>
    "    inoremap <left> <nop>
    "    inoremap <right> <nop>
        "nnoremap j gj
        "nnoremap k gk
    " }
    " Reminders {
        "+y (copy)
        "+x (cut)
        "+p (paste)
    " }
    " Functions {
        " Toggle background {
            function ToggleSolarizedBackground()
                if &background != 'light'
                    colorscheme solarized
                    set background=light
                else
                    colorscheme solarized
                    set background=dark
                endif
            endfunction
        " }
        " Toggle the arrow keys {
            function ToggleArrowKeys()
                if !exists('s:arrow_keys')
                    unmap <up>
                    unmap <down>
                    unmap <left>
                    unmap <right>
                    let s:arrow_keys = 1
                else
                    nnoremap <up> <nop>
                    nnoremap <down> <nop>
                    nnoremap <left> <nop>
                    nnoremap <right> <nop>
                    inoremap <up> <nop>
                    inoremap <down> <nop>
                    inoremap <left> <nop>
                    inoremap <right> <nop>
                    unlet s:arrow_keys
                endif
            endfunction
        " }
        " Toggle whitespace and tab display {
            function ToggleList()
                if &list
                    set nolist
                else
                    set list
                endif
            endfunction
        " }
        " Toggle visual highlighting of lines longer than 80 chars {
            function ToggleColorColumn()
                if exists('+colorcolumn')
                    if empty(&colorcolumn)
                        highlight ColorColumn ctermbg=red
                        if empty(&textwidth)
                            set colorcolumn=81
                        else
                            set colorcolumn=+1
                        endif
                    else
                        set colorcolumn=
                    endif
                else
                    if !exists('s:color_column')
                        highlight OverLength ctermbg=red ctermfg=white
                        match OverLength /\%81v.\+/
                        let s:color_column = 1
                    else
                        match OverLength //
                        unlet s:color_column
                    endif
                endif
            endfunction
        " }
        " Toggle line numbers {
            function ToggleNumber()
                if &number
                    set norelativenumber
                    set nonumber
                else
                    set norelativenumber
                    set number
                endif
            endfunction
        " }
        " Toggle relative line numbers {
            function ToggleRelNumber()
                if &relativenumber
                    set nonumber
                    set norelativenumber
                else
                    set number
                    set relativenumber
                endif
            endfunction
        " }
        " Toggle line wrap {
            function ToggleWrap()
                if &wrap
                    set nowrap
                else
                    set wrap
                endif
            endfunction
        " }
    " }
    " Function Keys {
        " Handling:
        " <F2> Toggle git diff cloumn
        map <silent><F2> :GitGutterToggle <CR>
        " <L-F2> Toggle git diff line highlighting
        map <silent><leader><F2> :GitGutterLineHighlightsToggle <CR>
        " <F3> Toggle the arrow keys
        map <silent><F3> :call ToggleArrowKeys() <CR>
        " <L-F3> Toggle mouse mode
        "TODO
        " <F4> Toggle paste mode
        set pastetoggle=<F4>
        " Looks:
        " <F5> Toggle whitespace and tab display
        map <silent><F5> :call ToggleList() <CR>
        " <L-F5> Toggle visual highlighting of lines longer than 80 chars
        map <silent><leader><F5> :call ToggleColorColumn() <CR>
        " <F6> Toggle line wrap
        map <silent><F6> :call ToggleNumber() <CR>
        " <L-F6> Toggle line numbers
        map <silent><leader><F6> :call ToggleRelNumber() <CR>
        " <F7> Toggle relative line numbers
        map <silent> <F7> :call ToggleWrap() <CR>
        " <L-F7> Toggle background
        call togglebg#map("<leader><F7>")
        map <silent><leader><F7> :call ToggleSolarizedBackground() <CR>
        " <F9> Toggle spell checking
        map <F8> :set spell!<CR><Bar>:echo 'Spell check: ' . strpart('OffOn', 3 * &spell, 3)<CR>
        " Functions:
        " <F12> Display all custom keybindings
        map <silent><F12> :!egrep '" <([LS]-)?F[1-9][0-2]?> ' ~/.vimrc <CR>
    " }
" }
" Settings for addons {
    " ctrlp {
        let g:ctrlp_extensions = ['tag', 'mixed']
    " }
    " vim-gitgutter {
        let g:gitgutter_enabled = 1
        highlight SignColumn ctermfg=239 ctermbg=235 guifg=Yellow
        highlight GitGutterAdd ctermfg=2 ctermbg=235 guifg=#009900
        highlight GitGutterChange ctermfg=3 ctermbg=235 guifg=#bbbb00
        highlight GitGutterDelete ctermfg=1 ctermbg=235 guifg=#ff2222
        " nmap <leader>j <Plug>GitGutterNextHunk
        " nmap <leader>k <Plug>GitGutterPrevHunk
        " Decrease amount of executions
        "let g:gitgutter_eager = 0
    " }
    " NERDtree {
         autocmd StdinReadPre * let s:std_in=1
         autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
         " Close vim if NERDtree is only window
         autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

         " https://github.com/scrooloose/nerdtree/issues/480
         function! NERDTreeToggleInCurDir()
             " If NERDTree is open in the current buffer
             if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
                 exe ":NERDTreeClose"
             else
                 if (expand("%:t") != '')
                     exe ":NERDTreeFind"
                 else
                     exe ":NERDTreeToggle"
                 endif
             endif
         endfunction

         " Toggle NERDtree with CTRL-e
         nnoremap <C-e> :call NERDTreeToggleInCurDir()<CR>

         " NERDTress File highlighting
         " https://github.com/scrooloose/nerdtree/issues/433#issuecomment-92590696

         " function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
         "  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
         "  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
         " endfunction
         "
         " call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
         " call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
         " call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
         " call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
         " call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
         " call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
         " call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
         " call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
         " call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
         " call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
         " call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
         " call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
         " call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
    " }
    " Airline.vim {
        augroup airline_config
            autocmd!
            let g:airline_theme='solarized'
            let g:airline_powerline_fonts = 1
            let g:airline_enable_syntastic = 1
            let g:airline#extensions#tabline#buffer_nr_format = '%s '
            let g:airline#extensions#tabline#buffer_nr_show = 1
            let g:airline#extensions#tabline#enabled = 1
            let g:airline#extensions#tabline#fnamecollapse = 0
            let g:airline#extensions#tabline#fnamemod = ':t'
        augroup END
    " }
    " syntastic {
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0
        let g:syntastic_eruby_ruby_quiet_messages = {'regex': 'possibly useless use of a variable in void context'}
    " }
" }

" Conditionals {
    if has('autocmd')
        augroup testgroup
        autocmd!
        " Filetype detection {
            au BufRead,BufNewFile *.j2          set ft=jinja
            au BufRead,BufNewFile *.hs          set ft=haskell
            au BufRead,BufNewFile *.ino,*.pde   set ft=arduino
            au BufRead,BufNewFile *.pp          set ft=puppet
            au BufRead,BufNewFile .vimrc        set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
            au BufRead,BufNewFile Capfile       set ft=ruby
            au BufRead,BufNewFile Vagrantfile*  set ft=ruby
            au BufRead,BufNewFile *.haml        set ft=haml
        " }
        " Filetype settings {
            au FileType arduino                 set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
            au FileType eruby,ruby,yaml,css,dot set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
            au FileType haskell                 set tabstop=4 softtabstop=2 shiftwidth=2 expandtab
            au FileType html                    set tabstop=2 softtabstop=2 shiftwidth=2 smartindent expandtab
            au FileType javascript              set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
            au FileType json                    set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
            au FileType lua                     set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
            au FileType perl                    set tabstop=8 softtabstop=4 shiftwidth=4 noexpandtab smarttab shiftround
            au FileType python                  set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
            au FileType sh,bash                 set tabstop=8 softtabstop=4 shiftwidth=4 expandtab
            au FileType tex                     set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
            au FileType vim                     set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
        " }
    endif
" }
