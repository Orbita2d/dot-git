call plug#begin('~/.local/share/nvim/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'lervag/vimtex'

call plug#end()



"+==========+
"| NERDTree |
"+==========+

let g:NERDTreeChDirMode = 2
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeNodeDelimiter = 'N'
"let g:NERDTreeDirArrowExpandable = '⯈'
"let g:NERDTreeDirArrowCollapsible = '⯆'

map <Leader>n :NERDTreeToggle<CR>
map <Leader>t :NERDTreeFocus<CR>
      
map <M-Left> :tabprevious<CR>
map <M-Right> :tabnext<CR>

"+==========+
"|  vimtex  |
"+==========+

let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

call deoplete#custom#var('omni', 'input_patterns', {
     \ 'tex': g:vimtex#re#deoplete
     \})

