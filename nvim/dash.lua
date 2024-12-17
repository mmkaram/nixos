local ascii_heatmap = require('git-dashboard-nvim').setup {
  show_only_weeks_with_commits = true,
}

local opts_one = {
theme = 'doom',
  config = {
    header = ascii_heatmap,
    center = {
      { icon = ' ', desc = 'Find File', action = 'Telescope find_files' },
      { icon = ' ', desc = 'Search Text', action = 'Telescope live_grep' },
      { icon = ' ', desc = 'Recent Files', action = 'Telescope oldfiles' },
    },
    footer = {
    'Lead them to Paradise',
    },
  },
}

local opts_two = {
  theme = 'doom',
  config = {
    packages = { enable = true },
    header = {
      '',
      '                                ',
      '#                              #',
      '###                          ###',
      '####                       #####',
      ' #####                    ##### ',
      '   #####                #####   ',
      '  ## #####            ##### ##  ',
      '   ### #####  ####  ##### ###   ',
      '     ### ##### ## ##### ###     ',
      '       ### ########## ###       ',
      '        ################        ',
      '          ### #### ###          ',
      '           ## #### ##           ',
      '            # #### #            ',
      '              ####              ',
      '               ##               ',
      '',
      'Lead them to Paradise.',
      '',
    },
    center = {
      { icon = ' ', desc = 'Find File', action = 'Telescope find_files' },
      { icon = ' ', desc = 'Search Text', action = 'Telescope live_grep' },
      { icon = ' ', desc = 'Recent Files', action = 'Telescope oldfiles' },
      -- { icon = ' ', desc = 'Open Config', action = 'edit ~/.config/nvim/init.lua' },
    },
    footer = {
      '',
      'I must not fear. Fear is the mind-killer.',
      'Fear is the little-death that brings total obliteration.',
      'I will face my fear. I will permit it to pass over me and through me.',
      'And when it has gone past, I will turn the inner eye to see its path.',
      'Where the fear has gone there will be nothing.',
      'Only I will remain.',
    }
  }
}

require('dashboard').setup(opts_two)
