{ config, pkgs, dotfiles, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # utilities
      telescope-nvim vim-easy-align vim-multiple-cursors vim-commentary vim-css-color vim-devicons which-key-nvim vim-eunuch vim-cursorword
      # visual 
      Shade-nvim nerdtree nvim-ts-rainbow
      # status bar
      lualine-nvim lualine-lsp-progress
      # better diagnostics
      ale popup-nvim
      # buffer stuff
      bufferline-nvim
      # auto complete
      nvim-cmp cmp-buffer cmp-path cmp_luasnip lspkind-nvim nvim-lspconfig lsp_signature-nvim
      # syntax highlighting
      zig-vim vim-nix nim-vim vim-polyglot vim-csharp
      # design stuff
      tokyonight-nvim indent-blankline-nvim
      # tree sitter
      (nvim-treesitter.withPlugins (_: with plugins; pkgs.tree-sitter.allGrammars)) 
    ];

    extraConfig = ''
      lua require('indent')
      lua require('init_sh')

      lua require('completion')

      lua require('init_ll')
      lua require('init_lsp')
      lua require('init_ts')
      lua require('init_bl')
      lua require('init_sde')

      let mapleader = "\<SPACE>"

      let g:ale_floating_preview = 1
      let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']

      " min width of word
      let g:cursorword_min_width = 3

      " max width of word
      let g:cursorword_max_width = 50
      let g:multi_cursor_use_default_mapping = 1

      let g:tokyonight_style = 'storm'
      let g:tokyonight_transparent_background = 1

      nnoremap <leader>n :NERDTreeFocus<cr>
      nnoremap <C-t> :NERDTreeToggle<cr>
      nnoremap <C-f> :NERDTreeFind<cr>

      noremap n j
      noremap e k
      noremap l i
      noremap i l
      noremap k n
      noremap j e

      vnoremap < <gv
      vnoremap > >gv
      vnoremap y myy`y
      vnoremap Y myY`y

      nnoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<cr>
      nnoremap <leader>g :ALEGoToDefinition<cr>
      nnoremap <leader>fr :ALEFindReferences<cr>
      nnoremap <leader>ss :ALESymbolSearch
      nnoremap <leader>r :ALERename

      nnoremap <leader>k :nohlsearch<cr>
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>tt <cmd>Telescope<cr>
      nnoremap <leader>w! :SudoWrite<cr>
      nnoremap <leader>e! :SudoEdit<cr>

      nnoremap <silent>[b :BufferLineCycleNext<CR>
      nnoremap <silent>b] :BufferLineCyclePrev<CR>
      nnoremap <silent><leader>bh :BufferLineMoveNext<CR>
      nnoremap <silent><leader>bl :BufferLineMovePrev<CR>
      nnoremap <silent>bd :BufferLineSortByDirectory<CR>

      vnoremap ga :EasyAlign<cr>

      vnoremap x "_x
      nnoremap x "_x

      set clipboard+=unnamedplus
      syntax on
      set hidden
      set nobackup
      set signcolumn=yes:2
      set nowritebackup
      set cmdheight=2
      set updatetime=300
      set shortmess+=c
      set backspace=2
      set visualbell
      set t_vb=
      set title
      set relativenumber
      set number
      set ruler
      set tabstop=2 shiftwidth=2 smarttab expandtab
      set noexpandtab
      set cursorline
      set encoding=UTF-8
      set smartcase
      set smartindent
      set ignorecase
      set cursorline
      set updatetime=300
      set redrawtime=10000

      colorscheme tokyonight
      set termguicolors
    '';
  };

  home.file = {
    ".config/nvim/lua" = {
      source = "${dotfiles}/nvim/lua";
    };
  };
}
