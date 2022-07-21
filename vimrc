set encoding=utf-8
let $IN_VIM = 'true'

" Leader
let mapleader = " "

set hidden        " Manage multiple buffers effectively: the current buffer can be "sent" to the background without writing to disk
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nocompatible  " Use Vim settings, rather then Vi settings. It’s important to have this on the top of your file, as it influences other options.
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set cursorline    " highlighting the cursorlino
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set modelines=0   " Disable modelines as a security precaution
set nomodeline
set autoread      " Automatically re-read files if unmodified inside Vim
set noerrorbells  " Disable beep on errors.
set visualbell    " Flash the screen instead of beeping on errors.
set incsearch     " Find the next match as we type the search.
set hlsearch      " Highlight searches by default.
set ignorecase    " Ignore case when searching . . .
set smartcase     " . . . unless you type a capital.
set scrolloff=3 " The number of screen lines to keep above and below the cursor.
set sidescrolloff=5 " The number of screen columns to keep to the left and right of the cursor.
set exrc
set secure
set undofile
set undodir=~/.vim/undodir/
set undolevels=2000
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldcolumn=1 "defines 1 col at window left, to indicate folding
let javaScript_fold=1 "activate folding by JS syntax
set foldlevelstart=99 "start file with all folds opened
"
" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces



" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
  autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
  autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
  autocmd BufRead,BufNewFile vimrc.local set filetype=vim
augroup END

" ALE linting events
augroup ale
  autocmd!

  if g:has_async
    autocmd VimEnter *
      \ set updatetime=1000 |
      \ let g:ale_lint_on_text_changed = 0
    autocmd CursorHold * call ale#Queue(0)
    autocmd CursorHoldI * call ale#Queue(0)
    autocmd InsertEnter * call ale#Queue(0)
    autocmd InsertLeave * call ale#Queue(0)
  else
    echoerr "The thoughtbot dotfiles require NeoVim or Vim 8"
  endif
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --vimgrep

  " Use ag in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'

endif

    nnoremap \ :Ag<SPACE>
" Make it obvious where 80 characters is
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Remove newbie crutches in Command Mode
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>

" Remove newbie crutches in Insert Mode
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>

" Remove newbie crutches in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

" Remove newbie crutches in Visual Mode
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" command shortcut
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <c-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-b> <S-Left>
cnoremap <C-w> <S-Right>

" insert shortcut
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <c-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-H> <Left>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-L> <Right>
inoremap <C-b> <S-Left>
inoremap <C-w> <S-Right>

let g:AutoPairsMapCh = 0
let g:AutoPairsMapBS = 0

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Set tags for vim-fugitive
set tags^=.git/tags

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" Map Ctrl + p to open fuzzy find (FZF)
" nnoremap <c-p> :Files<cr>
" nnoremap <C-b> :Buffers<CR>

nnoremap <c-p> <cmd>Telescope find_files<cr>
nnoremap <c-b> <cmd>Telescope buffers<cr>

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt=vertical

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" Relative Line Numbers
set rnu

function! FormatLua(buffer) abort
    return {
    \   'command': 'lua-format'
    \}
endfunction

execute ale#fix#registry#Add('lua-format', 'FormatLua', ['lua'], 'luafmt for lua')

let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {'vue': ['eslint', 'vls']}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint','prettier'],
\   'vue': ['eslint'],
\   'lua': ['lua-format'],
\ }
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 0
" https://github.com/dense-analysis/ale/issues/1176#issuecomment-348149374
let g:ale_cache_executable_check_failures = 1

" https://github.com/neoclide/coc.nvim/issues/1827
" slow Coc intellisense
let g:airline#extensions#hunks#enabled = 0

" ignore node_modules
:set wildignore+=**/node_modules/**
let g:netrw_browse_split = 4
let g:netrw_winsize = 20
" https://stackoverflow.com/a/57202529
set clipboard+=unnamed
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript']
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.

set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" inoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Right>"
" inoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Left>"
"
" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
"
" " Use K to show documentation in preview window.
" nnoremap <silent> <C-d> :call <SID>show_documentation()<CR>
"
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction
"
" " Highlight the symbol and its references when holding the cursor.
" augroup cursorhold
"   autocmd!
"   autocmd CursorHold * silent call CocActionAsync('highlight')
" augroup end
"
" " Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)
"
" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
"
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   " autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
"
" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
"
" " Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)
"
" " Introduce function text object
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)
"
" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :CocCommand eslint.executeAutofix
"
" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
" " Mappings using CoCList:
" " Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" " nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>sy  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" " nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"
" " open the current markdown in reveal js
" nnoremap <Leader>rr :new term://reveal-md % --css style.css --theme solarized --separator \"\^\\n\\n\\n\" --vertical-separator \"\^\\n\\n\" --watch<CR>
"
" " open the current markdown in reveal js
" nnoremap <Leader>rp :new term://reveal-md % --css style.css --theme solarized --separator \"\^\\n\\n\\n\" --vertical-separator \"\^\\n\\n\" --print %:r.pdf --print-size 1024x768<CR>
"
" let NERDTreeShowHidden=1
"
" " clean no name buffers
" function! CleanNoNameEmptyBuffers()
"     let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
"     if !empty(buffers)
"         exe 'bd '.join(buffers, ' ')
"     else
"         echo 'No buffer deleted'
"     endif
" endfunction
"
" nnoremap <silent> ,c :call CleanNoNameEmptyBuffers()<CR>
"
" au BufNewFile,BufRead Jenkinsfile setf groovy
"
"
" " https://github.com/skanehira/preview-markdown.vim#options
" let g:preview_markdown_vertical = 1
" let g:preview_markdown_parser = 'mdv'
" let g:preview_markdown_auto_update = 1
"
" " Use <C-l> for trigger snippet expand.
" " imap <C-l> <Plug>(coc-snippets-expand)
"
" " Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)
"
" " Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'
"
" " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'
"
" " Use <C-j> for both expand and jump (make expand higher priority.)
" " imap <C-j> <Plug>(coc-snippets-expand-jump):
"
" " https://github.com/neoclide/coc-yank
" nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>lcd :lcd %:p:h<CR>:pwd<CR>


set wildmenu
let g:sessions_dir = '~/vim-sessions'
exec 'nnoremap <Leader>ss :mksession! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

let g:yankring_replace_n_pkey = '<C-Y>'

"-- FOLDING --


nmap ,cs :let @*=expand("%")<CR>
nmap ,cl :let @*=expand("%:p")<CR>

function! PrintGivenRange() range
    echo "firstline ".a:firstline." lastline ".a:lastline
    " Do some more things
endfunction

nnoremap <buffer> <Leader>tr :TableModeRealign<cr>

" vim wiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]


au BufNewFile,BufRead *.groovy  setf groovy
au BufNewFile,BufRead Jenkinsfile setf groovy
if did_filetype()
  finish
endif
if getline(1) =~ '^#!.*[/\\]groovy\>'
  setf groovy
endif

"JIRA
let g:jiraVimDomainName = "naturalintelligence"
let g:jiraVimEmail      = "ran.itzhaki@naturalint.com"
let g:jiraVimToken      = "6u3Cc2qA5oagvhbdxs1FC7C8"

colorscheme gruvbox

" YankRing
let g:yankring_replace_n_pkey = '<Leader>p'

" set the path of coc to node12
let g:coc_node_path = '~/.nvm/versions/node/v14.17.3/bin/node'

" disable syntax for large files
augroup largefiel
  autocmd!
  autocmd BufWinEnter * if line2byte(line("$") + 1) > 100000 | syntax clear | endif
augroup end

" Goyo
let g:goyo_width = '85%'

function! s:goyo_enter()
  GitGutterEnable
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  Limelight!
  " ...
endfunction

augroup goyo
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup end

" Limelight
nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <Plug>(Limelight)


" coc spell cheker
" vmap <leader>a <Plug>(coc-codeaction-selected)
" nmap <leader>a <Plug>(coc-codeaction-selected)
"

" Vira status airline
let g:airline_section_z = '%{ViraStatusLine()}'

" search and replace highlighting:w
set icm=nosplit

if has('nvim')
  " run tests with neoterm in vim-test
  let g:test#strategy = 'neoterm'
endif
" For NeoVim {{{
if has('nvim')
  " use neovim-remote (pip3 install neovim-remote) allows
  " opening a new split inside neovim instead of nesting
  " neovim processes for git commit
    let $VISUAL      = 'nvr -cc split --remote-wait +"setlocal bufhidden=delete"'
    let $GIT_EDITOR  = 'nvr -cc split --remote-wait +"setlocal bufhidden=delete"'
    let $KUBE_EDITOR = 'nvr -l'
    let $EDITOR      = 'nvr -l'
    let $ECTO_EDITOR = 'nvr -l'

  " interactive find replace preview
    set inccommand=nosplit

    augroup TerminalMod
      autocmd!
      autocmd BufEnter *
            \ if &buftype == 'terminal' |
            \   setlocal foldcolumn=0 |
            \ endif
      autocmd TermEnter * setlocal foldcolumn=0
    augroup END


  " share data between nvim instances (registers etc)
    augroup SHADA
      autocmd!
      autocmd CursorHold,TextYankPost,FocusGained,FocusLost *
            \ if exists(':rshada') | rshada | wshada | endif
    augroup END

  " set pum background visibility to 20 percent
    set pumblend=20

  " set file completion in command to use pum
    set wildoptions=pum

  " Navigate neovim + neovim terminal emulator with alt+direction
    tnoremap <silent><C-h> <C-\><C-n><C-w>h
    tnoremap <silent><C-j> <C-\><C-n><C-w>j
    tnoremap <silent><C-k> <C-\><C-n><C-w>k
    tnoremap <silent><C-l> <C-\><C-n><C-w>l

  " easily escape terminal
  " tnoremap <leader><esc> <C-\><C-n><esc><cr>
    tnoremap <C-o> <C-\><C-n><esc><cr>

  " quickly toggle term

    function! Toggle_terminal_by_tab()
      execute "botright " . tabpagenr() . " Ttoggle"
    endfunction

    nnoremap <silent> <leader>O :call Toggle_terminal_by_tab()<cr><c-w>j
    nnoremap <silent> <leader>o :call Toggle_terminal_by_tab()<cr><c-w>j

    " close terminal
    " tnoremap <silent> <leader>o <C-\><C-n>:Ttoggle<cr>

  " send stuff to REPL using NeoTerm
    nnoremap <silent> <c-s>l :TREPLSendLine<CR>
    vnoremap <silent> <c-s>s :TREPLSendSelection<CR>

  " pasting works quite well in neovim as is so disabling yo
    nnoremap <silent> yo o
    nnoremap <silent> yO O
endif

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>


" let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
"
" " Turn on case-insensitive feature
" let g:EasyMotion_smartcase = 1
"
" " JK motions: Line motions
" nmap f <Plug>(easymotion-overwin-w)

nmap s :HopWord<cr>

let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_tranparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>

let g:jsdoc_lehre_path = "/Users/ran.itzhaki/.nvm/versions/node/v10.22.0/bin/lehre"

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" function! s:task(cmd, args)
"   if exists('a:cmd')
"     echo "Command: " . a:cmd
"   else
"     execute "new term://task"
"   endif
" endfunction
"
" command! -nargs=? Task call s:task(<args>)

let g:vimwiki_key_mappings =
  \ {
  \   'all_maps': 1,
  \   'global': 1,
  \   'headers': 1,
  \   'text_objs': 1,
  \   'table_format': 1,
  \   'table_mappings': 1,
  \   'lists': 1,
  \   'links': 1,
  \   'html': 1,
  \   'mouse': 0,
  \   'lists_return': 0,
  \ }



" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope git_files<cr>
nnoremap <leader>j <cmd>Telescope jumplist<cr>

let g:firenvim_config = {
	\ "globalSettings": {
		\ "server": "persistent"
	\}
\}

let $GH_USER='zamboney'
let $GH_PASS='558722296b0cef953892ae5dfd04531c1bafe53c'

set guifont=Monaco:h15

let g:Templates_InternetBrowserExec = 'firefox'

let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

let g:ale_disable_lsp = 1
" disable coc
" let g:coc_start_at_startup=0

" TMUX
let g:tmux_navigator_no_mappings = 1
" nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" integration with native nvim 0.5 lsp
let g:coc_start_at_startup = v:false

" Telescope builtin lists
function! s:telescope_gh(arg,line,pos)
  let l:extensions_subcommand_dict = luaeval('require("telescope.command").get_extensions_subcommand()')

  return join(get(l:extensions_subcommand_dict, 'gh', []),"\n")

endfunction

command! -nargs=* -complete=custom,s:telescope_gh GH    lua require('telescope.command').load_command('gh', <f-args>)

let g:languagetool_jar='$HOME/langtool/LanguageTool-5.2/languagetool-commandline.jar'

" start the neuron server and render markdown, auto reload on save
nnoremap <buffer> gzs <cmd>lua require'neuron'.rib {address = "127.0.0.1:8200", verbose = true}<CR>
