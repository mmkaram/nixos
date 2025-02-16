local ascii_heatmap = require('git-dashboard-nvim').setup {
  show_only_weeks_with_commits = true,
  show_contributions_count = false,
  days = { 's', 'm', 't', 'w', 't', 'f', 's' },
  filled_squares = { '█', '█', '█', '█', '█', '█' },
  empty_square = ' ',
  gap = '',
  colors = {
    -- tokinight colors
    days_and_months_labels = '#61afef',
    empty_square_highlight = '#3e4452',
    filled_square_highlights = { '#61afef', '#61afef', '#61afef', '#61afef', '#61afef', '#61afef' },
    branch_highlight = '#61afef',
    dashboard_title = '#61afef',
  },
}

local opts_one = {
  theme = 'doom',
  config = {
    header = ascii_heatmap,
    center = {
      { action = '', desc = '', icon = '', key = 'n' },
    },
    footer = function()
      return {}
    end,
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

local function setup_dashboard()
  local Path = require('plenary.path')
  local git_dir = Path:new('.git')

  if git_dir:exists() then
    require('dashboard').setup(opts_one)
  else
    require('dashboard').setup(opts_two)
  end
end
setup_dashboard()
