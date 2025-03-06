{pkgs}: let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  americano = import ../packages/americano-nvim/package.nix {inherit pkgs;};
  git-dashboard = import ../packages/git-dashboard-nvim/package.nix {inherit pkgs;};
in {
  enable = true;
  defaultEditor = true;

  plugins = with pkgs.vimPlugins; [
    # TODO:
    # alpha-lua
    # neo-tree
    {
      plugin = conform-nvim;
      config = toLuaFile ../nvim/format.lua;
    }
    telescope-file-browser-nvim
    # deps
    plenary-nvim
    nvim-web-devicons
    nui-nvim

    vim-be-good

    quickfix-reflector-vim

    americano

    # configured in dash.lua
    git-dashboard

    vim-prisma

    {
      plugin = trouble-nvim;
      config = toLuaFile ./trouble.lua;
    }

    {
      plugin = tmux-nvim;
      config = toLua "require('tmux').setup()";
    }

    {
      plugin = obsidian-nvim;
      config = toLuaFile ./obsidian.lua;
    }

    {
      plugin = neo-tree-nvim;
      config = toLua "require('neo-tree').setup({window={mappings = {['l'] = 'toggle_node',},},sources = {'filesystem', 'document_symbols'},}) ";
    }

    cmp_luasnip

    {
      plugin = luasnip;
      config = toLuaFile ./luasnip.lua;
    }

    {
      # idk how this is different from nvimp.cmp
      plugin = cmp-nvim-lsp;
      # this config isn't realted, it just loads
      # keybinds because I can't source lua files from
      # other lua files
      config = toLuaFile ../nvim/keys.lua;
    }

    {
      plugin = nvim-cmp;
      config = toLuaFile ../nvim/completion.lua;
    }

    {
      plugin = oil-nvim;
      config = toLua "require('oil').setup()";
    }

    {
      plugin = nvim-notify;
      config = toLuaFile ../nvim/notify.lua;
    }

    {
      plugin = markview-nvim;
      config = toLua "require('markview').setup()";
    }

    {
      plugin = guess-indent-nvim;
      config = toLua "require('guess-indent').setup()";
    }

    {
      plugin = dashboard-nvim;
      config = toLuaFile ../nvim/dash.lua;
    }

    {
      plugin = presence-nvim;
      config = toLuaFile ../nvim/presence.lua;
    }

    {
      plugin = indent-blankline-nvim;
      config = toLuaFile ../nvim/indent.lua;
    }

    {
      plugin = codewindow-nvim;
      config = toLuaFile ../nvim/codewindow.lua;
    }

    {
      plugin = zen-mode-nvim;
      config = toLua "require('zen-mode').setup()";
    }

    {
      plugin = lazygit-nvim;
      config = toLuaFile ../nvim/lazygit.lua;
    }

    {
      plugin = undotree;
      config = toLuaFile ../nvim/undo.lua;
    }

    # gh cli integration
    {
      plugin = octo-nvim;
      config = toLuaFile ../nvim/octo.lua;
    }

    # lines changed since last commit
    {
      plugin = gitsigns-nvim;
      config = toLua "require('gitsigns').setup()";
    }

    # status bar
    lualine-nvim
    {
      plugin = lualine-lsp-progress;
      config = toLuaFile ../nvim/lualine.lua;
    }

    {
      plugin = tokyonight-nvim;
      config = "colorscheme tokyonight-night";
      # config = "colorscheme americano";
    }

    {
      plugin = nvim-lspconfig;
      config = toLuaFile ../nvim/lsp.lua;
    }

    {
      plugin = comment-nvim;
      config = toLuaFile ../nvim/comment.lua;
    }

    {
      plugin = toggleterm-nvim;
      config = toLuaFile ../nvim/term.lua;
    }

    # tabs and stuff
    vim-unimpaired
    {
      plugin = bufferline-nvim;
      config = toLuaFile ../nvim/bufferline.lua;
    }

    {
      plugin = telescope-nvim;
      config = toLuaFile ../nvim/telescope.lua;
    }

    # configured in telescope.lua
    telescope-ui-select-nvim

    (nvim-treesitter.withPlugins (p: [
      p.tree-sitter-nix
      p.tree-sitter-python
      p.tree-sitter-bash
      p.tree-sitter-lua
      p.tree-sitter-json
      p.tree-sitter-rust
      p.tree-sitter-haskell
      p.tree-sitter-c
      p.tree-sitter-cpp
      p.tree-sitter-sql
      p.tree-sitter-prisma
    ]))

    vim-nix
  ];
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
}
