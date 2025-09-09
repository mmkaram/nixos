{pkgs}: let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  americano = import ../packages/americano-nvim/package.nix {inherit pkgs;};
  git-dashboard = import ../packages/git-dashboard-nvim/package.nix {inherit pkgs;};
in {
  enable = true;
  defaultEditor = true;

  plugins = with pkgs.vimPlugins; [
    # Dependencies
    plenary-nvim
    nvim-web-devicons
    nui-nvim

    # Util
    quickfix-reflector-vim
    {
      plugin = flash-nvim;
      config = toLua "require('flash').setup({})";
    }

    {
      plugin = mini-ai;
      config = toLua "require('mini.ai').setup()";
    }

    {
      plugin = which-key-nvim;
      config = toLuaFile ./whichkey.lua;
    }

    {
      plugin = autoclose-nvim;
      config = toLuaFile ./autoclose.lua;
    }

    {
      plugin = mini-surround;
      config = toLuaFile ./surround.lua;
    }

    {
      plugin = trouble-nvim;
      config = toLua "require('trouble')";
    }

    {
      plugin = tmux-nvim;
      config = toLua "require('tmux').setup()";
    }

    # {
    #   plugin = obsidian-nvim;
    #   config = toLuaFile ./obsidian.lua;
    # }

    {
      plugin = neo-tree-nvim;
      config = toLuaFile ./neotree.lua;
    }

    {
      plugin = luasnip;
      config = toLuaFile ./luasnip.lua;
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
      config = toLua "require('markview').setup({typst={enable = false}})";
    }

    {
      plugin = typst-preview-nvim;
      config = toLua "require('typst-preview')";
    }

    {
      plugin = guess-indent-nvim;
      config = toLua "require('guess-indent').setup()";
    }

    {
      plugin = toggleterm-nvim;
      config = toLuaFile ../nvim/term.lua;
    }

    {
      plugin = presence-nvim;
      config = toLuaFile ../nvim/presence.lua;
    }

    {
      plugin = codewindow-nvim;
      config = toLuaFile ../nvim/codewindow.lua;
    }

    {
      plugin = zen-mode-nvim;
      config = toLua "require('zen-mode').setup()";
    }
    # Git
    lazygit-nvim
    undotree
    {
      plugin = gitsigns-nvim;
      config = toLua "require('gitsigns').setup()";
    }
    # Themeing
    lualine-nvim
    vim-tpipeline
    {
      plugin = lualine-lsp-progress;
      config = toLuaFile ../nvim/lualine.lua;
    }
    {
      plugin = dashboard-nvim;
      config = toLuaFile ../nvim/dash.lua;
    }
    git-dashboard
    {
      plugin = tokyonight-nvim;
      config = "colorscheme tokyonight-night";
      # config = "colorscheme americano";
    }
    americano

    # Buffer management
    # vim-unimpaired
    {
      plugin = bufferline-nvim;
      config = toLuaFile ../nvim/bufferline.lua;
    }
    {
      plugin = telescope-nvim;
      config = toLuaFile ../nvim/telescope.lua;
    }
    telescope-ui-select-nvim
    telescope-file-browser-nvim
    # Formatting
    {
      plugin = conform-nvim;
      config = toLuaFile ../nvim/format.lua;
    }
    {
      plugin = comment-nvim;
      config = toLua "require('Comment').setup()";
    }
    {
      plugin = indent-blankline-nvim;
      config = toLuaFile ../nvim/indent.lua;
    }

    # LSP
    {
      plugin = codecompanion-nvim;
      config = toLuaFile ./companion.lua;
    }
    {
      plugin = nvim-cmp;
      config = toLuaFile ../nvim/completion.lua;
    }
    {
      plugin = nvim-lspconfig;
      config = toLuaFile ../nvim/lsp.lua;
    }
    {
      plugin = cmp-nvim-lsp;
      # this config isn't realted, it just loads
      # keybinds because I can't source lua files from
      # other lua files
      config = toLuaFile ../nvim/keys.lua;
    }
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
      p.tree-sitter-svelte
      p.tree-sitter-yaml
      p.tree-sitter-typst
    ]))
    vim-prisma
    vim-nix
    vim-svelte
    cmp_luasnip
  ];
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
}
